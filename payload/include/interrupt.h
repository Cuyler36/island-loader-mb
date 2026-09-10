#ifndef GUARD_INTERRUPT_H
#define GUARD_INTERRUPT_H

#include "gba/types.h"

typedef void (*InterruptHandler)(void);

void UnusedInterruptHandler(void);
void VBlankInterruptHandler(void);
void HBlankInterruptHandler(void);
void VCountInterruptHandler(void);

/* Original address: 0x02019B98 */
extern const InterruptHandler sInitialIntrTable[14];

/* Original address: 0x03000890 */
extern InterruptHandler gIntrTable[14];

#endif // GUARD_INTERRUPT_H
