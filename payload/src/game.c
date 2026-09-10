#include "game.h"
#include "global.h"
#include "joyboot.h"
#include "lib.h"
#include "m_msg.h"
#include "palette.h"

#define ISLAND_PROGRAM_SIZE 0x15244
#define ISLAND_DATA_SIZE    0x3980
#define JOYBUS_RECV_COMMAND 0xFFFE0202
#define ISLAND_PROGRAM_BUFFER ((u32 *)EWRAM_START)

enum LoaderTransferPhase {
    LOADER_PHASE_WAIT_PROGRAM_REQUEST,
    LOADER_PHASE_RECEIVE_PROGRAM,
    LOADER_PHASE_WAIT_ISLAND_REQUEST,
    LOADER_PHASE_RECEIVE_ISLAND,
    LOADER_PHASE_ERROR,
    LOADER_PHASE_WAIT_FOR_A,
    LOADER_PHASE_UNUSED,
    LOADER_PHASE_FADE_OUT,
    LOADER_PHASE_DONE = 9,
};

/* Original address: 0x0201B088 */
extern const u16 sLoaderPalette2Current[8];

/* Original address: 0x0201B098 */
extern const u16 sLoaderPalette3Current[5];

/* Original address: 0x0201B1E0 */
extern const u32 sLoaderBg0Tilemap[0x800];

/* Original address: 0x0201D1E0 */
extern const u32 sLoaderBg2Tilemap[0x800];

/* Original address: 0x0201F1E0 */
extern const u32 sLoaderBg3Tilemap[0x800];

/* Original address: 0x02021A30 */
extern const u32 sLoaderObjTiles[0x2000];

/* Original address: 0x02029A30 */
extern const u32 sLoaderBgTiles[0x2000];

/* Original address: 0x02031A30 */
extern const u16 sLoaderBgPalette[0x100];

/* Original address: 0x02031C30 */
extern const u32 sLoaderBg1Tilemap[0x800];

/* Original address: 0x02033C30 */
extern const u16 sLoaderObjPalette[0x100];

/* Original address: 0x0203B000 */
extern u8 gInitialIsland[ISLAND_DATA_SIZE];

/* Original address: 0x02018B1C */
static void InitializeLoaderPalette(void) {
    gGameState.bldcnt = 0x0441;
    gGameState.bldalpha = 0x1008;
    CpuCopy16(sLoaderPalette2Current, (void *)(PLTT + 0x190), sizeof(sLoaderPalette2Current));
    CpuCopy16(sLoaderPalette3Current, (void *)(PLTT + 0x1D6), sizeof(sLoaderPalette3Current));
    CpuFastCopy(gBgPaletteBank12, (void *)(PLTT + 0x180), 0x20);
    CpuFastCopy(gBgPaletteBank14, (void *)(PLTT + 0x1C0), 0x20);
}

/* Original address: 0x02018B90 */
void InitializeIsland(void) {
    EnableVBlankInterrupt();
    gGameState.frame_committed = 1;
    gGameState.loader_active = 1;
    gIslandTransferData = gInitialIsland;

    DmaCopy32(3, sLoaderObjTiles, (void *)OBJ_VRAM0, sizeof(sLoaderObjTiles));
    DmaFill16(3, 0, gBgObjPaletteBuffer, sizeof(gBgObjPaletteBuffer));
    DmaCopy32(3, sLoaderBgTiles, (void *)BG_VRAM, sizeof(sLoaderBgTiles));
    DmaCopy16(3, sLoaderBgPalette, gBgObjPaletteBuffer, sizeof(sLoaderBgPalette));
    DmaCopy16(3, sLoaderObjPalette, gObjPaletteBuffer, sizeof(sLoaderObjPalette));
    DmaCopy16(3, gBgObjPaletteBuffer, (void *)PLTT, PLTT_SIZE);

    gGameState.bg0cnt = 0xDC00;
    gGameState.bg1cnt = 0xD801;
    gGameState.bg2cnt = 0xD402;
    gGameState.bg3cnt = 0xD003;

    DmaCopy32(3, sLoaderBg0Tilemap,
              (void *)(BG_VRAM + ((gGameState.bg0cnt & 0x1F00) << 3)),
              sizeof(sLoaderBg0Tilemap));
    DmaCopy32(3, sLoaderBg1Tilemap,
              (void *)(BG_VRAM + ((gGameState.bg1cnt & 0x1F00) << 3)),
              sizeof(sLoaderBg1Tilemap));
    DmaCopy32(3, sLoaderBg2Tilemap,
              (void *)(BG_VRAM + ((gGameState.bg2cnt & 0x1F00) << 3)),
              sizeof(sLoaderBg2Tilemap));
    DmaCopy32(3, sLoaderBg3Tilemap,
              (void *)(BG_VRAM + ((gGameState.bg3cnt & 0x1F00) << 3)),
              sizeof(sLoaderBg3Tilemap));

    gGameState.dispcnt = 0x1E00;
    gGameState.bg1_hofs = 0;
    gGameState.bg1_vofs = 0x100;
    gGameState.bg2_hofs = 0;
    gGameState.bg2_vofs = 0x100;
    gGameState.reserved_000 = 0;
    gGameState.loader_mode++;
    gGameState.transfer_phase = LOADER_PHASE_WAIT_PROGRAM_REQUEST;

    mMsg_InitSprites();
    mMsg_CreateSprite(12, 0x80, 0x50, 0);
    CpuFastCopy(mFont_BlitGlyphToTiles, gFontGlyphBlitterCode, sizeof(gFontGlyphBlitterCode));
    Joybus_Init();
    InitializeLoaderPalette();
}

/* Original address: 0x02018D80 */
void IslandLoader_BeginJoybusReceive(void *buffer, s32 size) {
    gTransWork.transfer_size = size;
    gTransWork.buffer = buffer;
    gTransWork.enabled = 1;
}

/* Original address: 0x02018D94 */
void IslandLoader_LaunchProgram(void) {
    int (*entry)(void) = (int (*)(void))EWRAM_START;

    REG_IME = 0;
    REG_DISPSTAT = 0;
    REG_IE = 0;
    REG_IF = 0xFFFF;
    REG_DISPCNT = DISPCNT_FORCED_BLANK;
    entry();
}

/* Original address: 0x02018DD4 */
void Game_Update(void) {
    u16 saved_ime;

    mMsg_UpdateAndDrawSprites();

    switch (gGameState.transfer_phase) {
    case LOADER_PHASE_WAIT_PROGRAM_REQUEST:
        if (gTransWork.command == JOYBUS_RECV_COMMAND) {
            IslandLoader_BeginJoybusReceive(ISLAND_PROGRAM_BUFFER, ISLAND_PROGRAM_SIZE);
            gGameState.transfer_phase = LOADER_PHASE_RECEIVE_PROGRAM;
        }
        break;
    case LOADER_PHASE_RECEIVE_PROGRAM:
        if (gTransWork.result != 0) {
            if (gTransWork.result == 1) {
                gGameState.transfer_phase = LOADER_PHASE_WAIT_ISLAND_REQUEST;
            } else {
                gGameState.transfer_phase = LOADER_PHASE_ERROR;
            }
        } else if (gTransWork.connected == 0) {
            gGameState.transfer_phase = LOADER_PHASE_ERROR;
            Joybus_Reset();
        }
        break;
    case LOADER_PHASE_WAIT_ISLAND_REQUEST:
        if (gTransWork.command == JOYBUS_RECV_COMMAND) {
            IslandLoader_BeginJoybusReceive(gIslandTransferData, ISLAND_DATA_SIZE);
            gGameState.transfer_phase = LOADER_PHASE_RECEIVE_ISLAND;
        }
        break;
    case LOADER_PHASE_RECEIVE_ISLAND:
        if (gTransWork.result != 0) {
            if (gTransWork.result == 1) {
                gGameState.bg1_hofs = 0;
                gGameState.bg1_vofs = 0;
                gGameState.transfer_phase = LOADER_PHASE_WAIT_FOR_A;
            } else {
                gGameState.transfer_phase = LOADER_PHASE_ERROR;
            }
        } else if (gTransWork.connected == 0) {
            gGameState.transfer_phase = LOADER_PHASE_ERROR;
            Joybus_Reset();
        }
        break;
    case LOADER_PHASE_WAIT_FOR_A:
        if (gGameState.keys.buttons.pressed & 1) {
            saved_ime = REG_IME;

            REG_IME = 0;
            REG_RCNT = 0x8000;
            REG_IME = saved_ime;
            GameState_SetBrightnessFade(&gGameState, 0x80, 0x3F, 0);
            gGameState.transfer_phase = LOADER_PHASE_FADE_OUT;
        }
        break;
    case LOADER_PHASE_FADE_OUT:
        if (GameState_StepBrightnessFade(&gGameState, 1, 1) == 0x10) {
            IslandLoader_LaunchProgram();
        }
        break;
    default:
        if (gGameState.transfer_phase == LOADER_PHASE_ERROR) {
            saved_ime = REG_IME;

            REG_IME = 0;
            REG_RCNT = 0x8000;
            REG_IME = saved_ime;
            gGameState.bg1_hofs = 0x100;
            gGameState.bg1_vofs = 0;
            gGameState.transfer_phase = LOADER_PHASE_DONE;
        }
        break;
    }
}

/* Original address: 0x02019024 */
void Game_Main(void) {
    vu8 __pad; // necessary for stack pad

    for (;;) {
        GameModeProc proc;

        GameState_ReadKeys();
        ClearOamBuffer();
        if (gGameState.dispatch_paused == 0) {
            proc = sGameModeProcs[gGameState.loader_mode];
            if (proc != 0) {
                proc();
            }
        }
        Joybus_CheckTimeout(1);
        gGameState.frame_committed = 0;
        WaitForVBlank();
    }
}
