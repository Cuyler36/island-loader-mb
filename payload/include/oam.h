#ifndef OAM_H
#define OAM_H

#include "gba/types.h"

typedef struct OAMData {
    u32 y : 8;
    u32 affine_mode : 2;
    u32 obj_mode : 2;
    u32 mosaic : 1;
    u32 bpp : 1;
    u32 shape : 2;
    u32 x : 9;
    u32 matrix_num : 3;
    u32 h_flip : 1;
    u32 v_flip : 1;
    u32 size : 2;
    u16 tile_num : 10;
    u16 priority : 2;
    u16 palette_num : 4;
    u16 affine_param;
} OAMData;

#endif
