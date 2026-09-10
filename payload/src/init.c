#include "game.h"
#include "global.h"

void _intr(void);

/* Original address: 0x02018428 */
void InitializeHardware(void) {
    RegisterRamReset(RESET_SOUND_REGS | RESET_REGS);
    DmaFill32(3, 0, (void *)IWRAM_START, 0x7800);
    DmaFill32(3, 0, (void *)VRAM, VRAM_SIZE);
    REG_WAITCNT = 0x4014;
    DmaCopy16(3, sInitialIntrTable, gIntrTable, sizeof(sInitialIntrTable));
    DmaCopy16(3, _intr, gGameState.interrupt_code, sizeof(gGameState.interrupt_code));
    INTR_VECTOR = gGameState.interrupt_code;
}
