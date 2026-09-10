#include "interrupt.h"
#include "audio.h"
#include "game.h"
#include "global.h"

/* Original address: 0x0201821C */
void UnusedInterruptHandler(void) {
}

/* Original address: 0x02018220 */
void VBlankInterruptHandler(void) {
    u8 committed = gGameState.frame_committed;

    if (committed == 0) {
        CpuFastCopy(gOamBuffer, (void *)OAM, sizeof(gOamBuffer));
        REG_DISPCNT = gGameState.dispcnt;
        REG_BG0HOFS = gGameState.bg0_hofs;
        REG_BG0VOFS = gGameState.bg0_vofs;
        REG_BG1HOFS = gGameState.bg1_hofs;
        REG_BG1VOFS = gGameState.bg1_vofs;
        REG_BG2HOFS = gGameState.bg2_hofs;
        REG_BG2VOFS = gGameState.bg2_vofs;
        REG_BG3HOFS = gGameState.bg3_hofs;
        REG_BG3VOFS = gGameState.bg3_vofs;
        REG_BLDALPHA = gGameState.bldalpha;
        REG_BLDY = gGameState.bldy;
        REG_BLDCNT = gGameState.bldcnt;
        REG_BG0CNT = gGameState.bg0cnt;
        REG_BG1CNT = gGameState.bg1cnt;
        REG_BG2CNT = gGameState.bg2cnt;
        REG_BG3CNT = gGameState.bg3cnt;

        if (gGameState.vblank_latch == 1) {
            gGameState.vblank_latch = committed;
        }

        gGameState.vblank_counter++;
        gGameState.frame_committed = 1;
    }

    REG_IF = gGameState.vblank_flags = 1;
    REG_DISPSTAT = 8;
    GameAudio_UpdateDriver();
}

/* Original address: 0x02018340 */
void HBlankInterruptHandler(void) {
}

/* Original address: 0x02018344 */
void VCountInterruptHandler(void) {
}
