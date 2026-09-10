#ifndef GUARD_GAME_H
#define GUARD_GAME_H

#include "gba/types.h"
#include "interrupt.h"
#include "oam.h"

typedef union GameKeys {
    struct {
        u16 held;
        u16 pressed;
    } buttons;
    u32 combined;
} GameKeys;

/* Shared layout used by both Animal Island multiboot images. */
typedef struct GameState {
    /* 0x000 */ u32 reserved_000;
    /* 0x004 */ s32 reserved_004;
    /* 0x008 */ s32 sleep_timer;
    /* 0x00C */ u32 rng_state;
    /* 0x010 */ u32 game_time_frames;
    /* 0x014 */ u32 interrupt_code[0x200];
    /* 0x814 */ vu16 vblank_flags;
    /* 0x816 */ u16 current_music_id;
    /* 0x818 */ GameKeys keys;
    /* 0x81C */ u16 bldalpha;
    /* 0x81E */ u16 bldy;
    /* 0x820 */ u16 bldcnt;
    /* 0x822 */ u16 bg0cnt;
    /* 0x824 */ u16 bg1cnt;
    /* 0x826 */ u16 bg2cnt;
    /* 0x828 */ u16 bg3cnt;
    /* 0x82A */ u16 dispcnt;
    /* 0x82C */ u8 reserved_82C[0x10];
    /* 0x83C */ u16 bg0_hofs;
    /* 0x83E */ u16 bg0_vofs;
    /* 0x840 */ u16 bg1_hofs;
    /* 0x842 */ u16 bg1_vofs;
    /* 0x844 */ u16 bg2_hofs;
    /* 0x846 */ u16 bg2_vofs;
    /* 0x848 */ u16 bg3_hofs;
    /* 0x84A */ u16 bg3_vofs;
    /* 0x84C */ u8 reserved_84C[4];
    /* 0x850 */ u8 dispatch_paused;
    /* 0x851 */ u8 reserved_851;
    /* 0x852 */ u8 palette_dirty;
    /* 0x853 */ u8 reserved_853[5];
    /* 0x858 */ u8 loader_active;
    /* 0x859 */ u8 vblank_latch;
    /* 0x85A */ u8 reserved_85A;
    /* 0x85B */ u8 vblank_counter;
    /* 0x85C */ s8 loader_mode;
    /* 0x85D */ u8 reserved_85D;
    /* 0x85E */ s8 transfer_phase;
    /* 0x85F */ u8 frame_committed;
    /* 0x860 */ u8 oam_count;
} GameState;

typedef void (*GameModeProc)(void);

void InitializeHardware(void);
void InitializeIsland(void);
void IslandLoader_BeginJoybusReceive(void *buffer, s32 size);
void IslandLoader_LaunchProgram(void);
void Game_Update(void);
void Game_Main(void);

/* Original address: 0x03000020 */
extern GameState gGameState;

/* Original address: 0x03000E40 */
extern void *gIslandTransferData;

/* Original address: 0x030008E0 */
extern OAMData gOamBuffer[128];

/* Original address: 0x03000CE0 */
extern u32 gFontGlyphBlitterCode[0x58];

/* Original address: 0x0201B080 */
extern const GameModeProc sGameModeProcs[2];

#endif // GUARD_GAME_H
