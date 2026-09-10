#ifndef M_MSG_H
#define M_MSG_H

#include "gba/types.h"
#include "oam.h"

typedef struct AnimFrameData {
    /* 0x00 */ OAMData *oam;
    /* 0x04 */ u16 duration;
    /* 0x06 */ s8 action_flag;
    /* 0x07 */ u8 pad;
} AnimFrameData;

typedef struct m_msg_sprite_s {
    /* 0x00 */ void (*init)(struct m_msg_sprite_s *);
    /* 0x04 */ void (*destroy)(struct m_msg_sprite_s *);
    /* 0x08 */ void (*update)(struct m_msg_sprite_s *);
    /* 0x0C */ void (*draw)(struct m_msg_sprite_s *);
    /* 0x10 */ void (*state_proc)(struct m_msg_sprite_s *);
    /* 0x14 */ s32 param;
    /* 0x18 */ s32 _18;
    /* 0x1C */ s32 _1C;
    /* 0x20 */ s32 offset_x;
    /* 0x24 */ s32 offset_y;
    /* 0x28 */ s32 _28;
    /* 0x2C */ s32 x;
    /* 0x30 */ s32 y;
    /* 0x34 */ s16 frame_timer;
    /* 0x36 */ s16 frame_index;
    /* 0x38 */ s16 animation_index;
    /* 0x3A */ u16 affine_scale_x;
    /* 0x3C */ u16 affine_scale_y;
    /* 0x3E */ u16 _3E;
    /* 0x40 */ u16 _40;
    /* 0x42 */ s8 part_frame_timers[10];
    /* 0x4C */ s8 part_frame_indices[10];
    /* 0x56 */ u8 state;
    /* 0x57 */ u8 type;
    /* 0x58 */ u8 _58;
    /* 0x59 */ u8 pad_59[7];
} m_msg_sprite_c;

typedef struct mMsg_SpriteProfile {
    void (*init)(m_msg_sprite_c *);
    void (*destroy)(m_msg_sprite_c *);
    void (*update)(m_msg_sprite_c *);
    void (*draw)(m_msg_sprite_c *);
} mMsg_SpriteProfile;

/* Scratch description used while drawing one eight-row message glyph. */
typedef struct mFont_GlyphDraw {
    u8 *tile_data;
    u16 tile_offset;
    u16 row;
    u16 tile_stride;
    u8 reserved_0A[4];
    u8 palette;
    u8 reserved_0F;
    u8 glyph_lower_rows[8];
    u8 glyph_upper_rows[8];
} mFont_GlyphDraw_c;

void mFont_GetGlyphRows(void *lower_rows, void *upper_rows, u8 character);
int mFont_GetGlyphWidth(u32 character);
int mFont_GetCodeWidth(u32 character);
s32 mFont_DrawStringToTiles(u8 *tile_data, u16 *cursor, u16 y, u16 tile_stride,
                            u8 *text, s32 length, u8 palette,
                            u8 stop_at_newline, u8 fixed_width);
void mFont_DrawCharToTiles(u8 *tile_data, s32 tile_offset, s32 row,
                           s32 tile_stride, s32 character, s32 palette, s32 width);
void mFont_CopyTileBufferToVram(s8 index);
void mFont_FillTileBuffer(u8 value, s8 index);
void mFont_BlitGlyphToTiles(mFont_GlyphDraw_c *glyph, s32 width);

void mMsg_InitSprites(void);
void mMsg_DeactivateSprite(m_msg_sprite_c *sprite);
m_msg_sprite_c *mMsg_CreateSprite(u8 type, s32 x, s32 y, s32 param);
s32 mMsg_FindSpriteByType(u8 type);
s32 mMsg_IsSpriteAnimationFinished(m_msg_sprite_c *sprite, AnimFrameData *const *animations);
void mMsg_StartSpriteAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations, s16 animation);
void mMsg_UpdateSpriteAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations);
void mMsg_CopySpriteOam(m_msg_sprite_c *sprite, OAMData *source, OAMData *dest);
void mMsg_UpdateAndDrawSprites(void);
void mMsg_StartSpritePartAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations,
                                   s32 animation, s32 part);
s32 mMsg_UpdateSpritePartAnimation(m_msg_sprite_c *sprite, AnimFrameData *const *animations, s32 part);
s32 mMsg_UpdateSpritePartAnimationReverse(m_msg_sprite_c *sprite, AnimFrameData *const *animations,
                                          s32 part);
void mMsg_SetObjAffineMatrix(u16 x_scale, u16 y_scale, u8 angle, s32 matrix_index);
void mMsg_LoaderAffineSpriteIdle(m_msg_sprite_c *sprite);
void mMsg_LoaderAffineSpriteInit(m_msg_sprite_c *sprite);
void mMsg_LoaderAffineSpriteDestroy(m_msg_sprite_c *sprite);
void mMsg_LoaderAffineSpriteUpdate(m_msg_sprite_c *sprite);
void mMsg_LoaderAffineSpriteDraw(m_msg_sprite_c *sprite);

/* Original address: 0x0201B0B4 */
extern mMsg_SpriteProfile mMsg_null_sprite_profile;

/* Original address: 0x0201B0C4 */
extern mMsg_SpriteProfile *sMsgSpriteProfiles[13];

/* Original address: 0x0201B0F8 */
extern mMsg_SpriteProfile mMsg_loader_affine_sprite_profile;

#endif
