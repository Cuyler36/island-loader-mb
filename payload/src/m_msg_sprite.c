#include "global.h"
#include "m_msg.h"

#define MSG_SPRITE_COUNT 12

/* Original address: 0x03000EB0 */
extern m_msg_sprite_c gMsgSprites[MSG_SPRITE_COUNT];

/* Original address: 0x030008E0 */
extern OAMData gOamBuffer[128];

/* Original address: 0x0201ADF8 */
extern const s16 sObjAffineSinTable[];

/* Original address: 0x020187A8 */
extern s16 FixedMul8(s16 lhs, s16 rhs);

/* These canonical profile objects remain in data.bin. */
/* Original address: 0x0201B0B4 */
extern mMsg_SpriteProfile mMsg_null_sprite_profile;

/* Original address: 0x0201B0C4 */
extern mMsg_SpriteProfile *sMsgSpriteProfiles[13];

/* Original address: 0x0201B0F8 */
extern mMsg_SpriteProfile mMsg_loader_affine_sprite_profile;

/* Original address: 0x02019548 */
void mMsg_InitSprites(void) {
    s32 zero;

    zero = 0;
    CpuFastSet(&zero, gMsgSprites, 0x01000120U);
}

/* Original address: 0x02019568 */
void mMsg_DeactivateSprite(m_msg_sprite_c *sprite) {
    sprite->type = 0;
    sprite->update = NULL;
    sprite->draw = NULL;
}

/* Original address: 0x02019578 */
m_msg_sprite_c *mMsg_CreateSprite(u8 type, s32 x, s32 y, s32 param) {
    u32 zero;
    m_msg_sprite_c *result = NULL;
    s32 index = mMsg_FindSpriteByType(0);

    if (index >= 0) {
        const mMsg_SpriteProfile *profile = sMsgSpriteProfiles[type];
        m_msg_sprite_c *sprite;

        zero = 0;
        sprite = &gMsgSprites[index];
        CpuFastSet(&zero, sprite, 0x01000018U);
        gMsgSprites[index].init = profile->init;
        gMsgSprites[index].destroy = profile->destroy;
        gMsgSprites[index].update = profile->update;
        gMsgSprites[index].draw = profile->draw;
        sprite->type = type;
        gMsgSprites[index].x = x;
        gMsgSprites[index].y = y;
        gMsgSprites[index].param = param;
        if (sprite->init != NULL) {
            sprite->init(sprite);
        }
        result = sprite;
    }
    return result;
}

static inline s32 mMsg_ScanSpriteType(u8 type) {
    s32 i;

    for (i = 0; i < MSG_SPRITE_COUNT; i++) {
        if (gMsgSprites[i].type == type) {
            break;
        }
    }
    return i;
}

/* Original address: 0x02019630 */
s32 mMsg_FindSpriteByType(u8 type) {
    s32 index = mMsg_ScanSpriteType(type);

    if (index >= MSG_SPRITE_COUNT) {
        index = -1;
    }
    return index;
}

/* Original address: 0x02019660 */
s32 mMsg_IsSpriteAnimationFinished(m_msg_sprite_c *sprite, AnimFrameData *const *animations) {
    s32 finished = 0;
    AnimFrameData *frames = animations[sprite->animation_index];

    if (sprite->frame_timer == 0 && frames[sprite->frame_index + 1].oam == NULL) {
        finished = 1;
    }
    return finished;
}

/* Original address: 0x02019690 */
void mMsg_StartSpriteAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations, s16 animation) {
    sprite->animation_index = animation;
    sprite->frame_timer = animations[sprite->animation_index][0].duration;
    sprite->frame_index = 0;
}

/* Original address: 0x020196AC */
void mMsg_UpdateSpriteAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations) {
    AnimFrameData *frames = animations[sprite->animation_index];

    if (sprite->frame_timer - 1 <= 0) {
        u8 action_flag;

        if (frames[sprite->frame_index + 1].oam == NULL) {
            action_flag = (u8)frames[sprite->frame_index].action_flag;
            if (action_flag != 0) {
                sprite->frame_index = 0;
            } else {
                sprite->frame_timer = 0;
                return;
            }
        } else {
            sprite->frame_index++;
        }
        sprite->frame_timer = frames[sprite->frame_index].duration;
    } else {
        sprite->frame_timer--;
    }
}

/* Original address: 0x020196F8 */
void mMsg_CopySpriteOam(m_msg_sprite_c *sprite, OAMData *source, OAMData *dest) {
    dest->y = source->y + sprite->y + sprite->offset_y;
    dest->affine_mode = source->affine_mode;
    dest->obj_mode = source->obj_mode;
    dest->mosaic = source->mosaic;
    dest->bpp = source->bpp;
    dest->shape = source->shape;
    dest->x = source->x + sprite->x + sprite->offset_x;
    dest->matrix_num = source->matrix_num;
    dest->h_flip = source->h_flip;
    dest->v_flip = source->v_flip;
    dest->size = source->size;
    dest->tile_num = source->tile_num;
    dest->priority = source->priority;
    dest->palette_num = source->palette_num;
    dest->affine_param = source->affine_param;
}

/* Original address: 0x02019808 */
void mMsg_UpdateAndDrawSprites(void) {
    s32 i;

    for (i = 0; i < MSG_SPRITE_COUNT; i++) {
        if (gMsgSprites[i].type != 0 && gMsgSprites[i].update != NULL) {
            gMsgSprites[i].update(&gMsgSprites[i]);
        }
    }
    for (i = 0; i < MSG_SPRITE_COUNT; i++) {
        if (gMsgSprites[i].type != 0 && gMsgSprites[i].draw != NULL) {
            gMsgSprites[i].draw(&gMsgSprites[i]);
        }
    }
}

/* Original address: 0x02019860 */
void mMsg_StartSpritePartAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations,
                                   s32 animation, s32 part) {
    AnimFrameData *frames = animations[animation];

    sprite->part_frame_timers[part] = frames[0].duration;
    sprite->part_frame_indices[part] = 0;
}

/* Original address: 0x02019880 */
s32 mMsg_UpdateSpritePartAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations, s32 part) {
    AnimFrameData *frames = animations[part];

    if (sprite->part_frame_timers[part] - 1 <= 0) {
        if (frames[sprite->part_frame_indices[part] + 1].oam == NULL) {
            if ((u8)frames[sprite->part_frame_indices[part] + 1].action_flag != 0) {
                sprite->part_frame_indices[part] = 0;
            } else {
                sprite->part_frame_timers[part] = 0;
                return 1;
            }
        } else {
            sprite->part_frame_indices[part]++;
        }
        sprite->part_frame_timers[part] = frames[sprite->part_frame_indices[part]].duration;
    } else {
        sprite->part_frame_timers[part]--;
    }
    return 0;
}

/* Original address: 0x02019900 */
s32 mMsg_UpdateSpritePartAnimationReverse(m_msg_sprite_c *sprite, AnimFrameData *const *animations,
                                      s32 part) {
    AnimFrameData *frames = animations[part];

    if (sprite->part_frame_timers[part] - 1 <= 0) {
        if (sprite->part_frame_indices[part] == 0) {
            return 1;
        }
        sprite->part_frame_indices[part]--;
        sprite->part_frame_timers[part] = frames[sprite->part_frame_indices[part]].duration;
    } else {
        sprite->part_frame_timers[part]--;
    }
    return 0;
}

/* Original address: 0x0201994C */
void mMsg_SetObjAffineMatrix(u16 x_scale, u16 y_scale, u8 angle, s32 matrix_index) {
    OAMData *oam = gOamBuffer;
    u8 rotation = angle;
    s16 cosine = sObjAffineSinTable[rotation + 0x40];
    s16 pa = FixedMul8(cosine, x_scale);
    OAMData *matrix = &oam[matrix_index * 4];

    matrix[0].affine_param = pa;
    matrix[1].affine_param = FixedMul8(sObjAffineSinTable[rotation], x_scale);
    matrix[2].affine_param = FixedMul8(-sObjAffineSinTable[rotation], y_scale);
    matrix[3].affine_param = FixedMul8(cosine, y_scale);
}

/* Original address: 0x020199D4 */
void mMsg_LoaderAffineSpriteIdle(m_msg_sprite_c *sprite) {
    /* This automatic initializer is emitted at original address 0x0201B108. */
    s32 unused[] = { 10, 9, 8, 6, 4, 2 };
}

/* Original address: 0x020199F0 */
void mMsg_LoaderAffineSpriteInit(m_msg_sprite_c *sprite) {
    sprite->_28 = 0x40;
    sprite->_40 = 0x50;
    sprite->_3E = 0;
    sprite->offset_x = -8;
    sprite->_58 = 0;
    sprite->_1C = 0;
    sprite->_18 = 0x40;
    sprite->state = 0;
    sprite->affine_scale_y = 0x100;
    sprite->affine_scale_x = 0x100;
    sprite->state_proc = mMsg_LoaderAffineSpriteIdle;
    sprite->state_proc(sprite);
}

/* Original address: 0x02019A3C */
void mMsg_LoaderAffineSpriteDestroy(m_msg_sprite_c *sprite) {
}

/* Original address: 0x02019A40 */
void mMsg_LoaderAffineSpriteUpdate(m_msg_sprite_c *sprite) {
    if (sprite->state_proc != NULL) {
        sprite->state_proc(sprite);
    }
}

/* Original address: 0x02019A50 */
void mMsg_LoaderAffineSpriteDraw(m_msg_sprite_c *sprite) {
    mMsg_SetObjAffineMatrix(sprite->affine_scale_x, sprite->affine_scale_y, 0, 0);
}
