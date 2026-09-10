#ifndef GUARD_PALETTE_H
#define GUARD_PALETTE_H

#include "gba/gba.h"

/* The linker places all 32 banks contiguously, BG followed by OBJ.
 * The span symbols below alias that storage for indexed access and DMA. */
/* Original address: 0x02038000 */
extern u8 gBgObjPaletteBuffer[PLTT_SIZE];

/* Original address: 0x02038000 */
extern u16 gBgPaletteBuffer[BG_PLTT_SIZE / sizeof(u16)];

/* Original address: 0x02038200 */
extern u16 gObjPaletteBuffer[OBJ_PLTT_SIZE / sizeof(u16)];

/* Original address: 0x02038000 */
extern u16 gBgPaletteBank0[16];

/* Original address: 0x02038020 */
extern u16 gBgPaletteBank1[16];

/* Original address: 0x02038040 */
extern u16 gBgPaletteBank2[16];

/* Original address: 0x02038060 */
extern u16 gBgPaletteBank3[16];

/* Original address: 0x02038080 */
extern u16 gBgPaletteBank4[16];

/* Original address: 0x020380A0 */
extern u16 gBgPaletteBank5[16];

/* Original address: 0x020380C0 */
extern u16 gBgPaletteBank6[16];

/* Original address: 0x020380E0 */
extern u16 gBgPaletteBank7[16];

/* Original address: 0x02038100 */
extern u16 gBgPaletteBank8[16];

/* Original address: 0x02038120 */
extern u16 gBgPaletteBank9[16];

/* Original address: 0x02038140 */
extern u16 gBgPaletteBank10[16];

/* Original address: 0x02038160 */
extern u16 gBgPaletteBank11[16];

/* Original address: 0x02038180 */
extern u16 gBgPaletteBank12[16];

/* Original address: 0x020381A0 */
extern u16 gBgPaletteBank13[16];

/* Original address: 0x020381C0 */
extern u16 gBgPaletteBank14[16];

/* Original address: 0x020381E0 */
extern u16 gBgPaletteBank15[16];

/* Original address: 0x02038200 */
extern u16 gObjPaletteBank0[16];

/* Original address: 0x02038220 */
extern u16 gObjPaletteBank1[16];

/* Original address: 0x02038240 */
extern u16 gObjPaletteBank2[16];

/* Original address: 0x02038260 */
extern u16 gObjPaletteBank3[16];

/* Original address: 0x02038280 */
extern u16 gObjPaletteBank4[16];

/* Original address: 0x020382A0 */
extern u16 gObjPaletteBank5[16];

/* Original address: 0x020382C0 */
extern u16 gObjPaletteBank6[16];

/* Original address: 0x020382E0 */
extern u16 gObjPaletteBank7[16];

/* Original address: 0x02038300 */
extern u16 gObjPaletteBank8[16];

/* Original address: 0x02038320 */
extern u16 gObjPaletteBank9[16];

/* Original address: 0x02038340 */
extern u16 gObjPaletteBank10[16];

/* Original address: 0x02038360 */
extern u16 gObjPaletteBank11[16];

/* Original address: 0x02038380 */
extern u16 gObjPaletteBank12[16];

/* Original address: 0x020383A0 */
extern u16 gObjPaletteBank13[16];

/* Original address: 0x020383C0 */
extern u16 gObjPaletteBank14[16];

/* Original address: 0x020383E0 */
extern u16 gObjPaletteBank15[16];

#endif /* GUARD_PALETTE_H */
