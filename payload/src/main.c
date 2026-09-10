#include "main.h"
#include "game.h"

/* Original address: 0x0201820C */
void AgbMain(void) {
    InitializeHardware();
    Game_Main();
}
