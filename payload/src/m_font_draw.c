#include "m_msg.h"
#include "global.h"
#include "gba/macro.h"
#include <string.h>

#define CHAR_CONTROL_CODE 0x7F
#define CHAR_NEW_LINE     0xCD

/* Original address: 0x0201ADE0 */
extern void *const sFontTileBufferVramDestinations[3];

/* Original address: 0x0201ADEC */
extern const u32 sFontTileBufferSizes[3];

/* Original address: 0x03000E50 */
extern mFont_GlyphDraw_c gMsgGlyph;

/* Original address: 0x020184B8 */
s32 mFont_DrawStringToTiles(u8 *tile_data, u16 *cursor, u16 y, u16 tile_stride,
                            u8 *text, s32 length, u8 palette,
                            u8 stop_at_newline, u8 fixed_width) {
    s32 characters_drawn;
    u32 character;
    s32 character_width;
    u16 current_x;

    for (characters_drawn = 0; characters_drawn < length; characters_drawn++) {
        character = text[characters_drawn];
        if ((stop_at_newline == 1 && character == CHAR_NEW_LINE) ||
            character == CHAR_CONTROL_CODE) {
            break;
        }
        character++, character--;
        if (fixed_width != 1) {
            character_width = mFont_GetGlyphWidth(character);
        } else {
            character_width = 8;
        }
        current_x = *cursor;
        if (character_width + current_x > tile_stride * 8) {
            break;
        }
        mFont_DrawCharToTiles(tile_data + (((y >> 3) * tile_stride) << 5),
                              current_x, y & 7, tile_stride, character, palette,
                              character_width - 1);
        *cursor += character_width;
    }
    return characters_drawn;
}

/* Original address: 0x0201856C */
void mFont_DrawCharToTiles(u8 *tile_data, s32 tile_offset, s32 row,
                           s32 tile_stride, s32 character, s32 palette, s32 width) {
    mFont_GlyphDraw_c *glyph = &gMsgGlyph;

    glyph->tile_data = tile_data;
    glyph->tile_offset = tile_offset;
    glyph->row = row;
    glyph->tile_stride = tile_stride;
    glyph->palette = palette;
    mFont_GetGlyphRows(glyph->glyph_lower_rows, glyph->glyph_upper_rows, character);
    mFont_BlitGlyphToTiles(glyph, width);
}

/* Original address: 0x020185A4 */
void mFont_CopyTileBufferToVram(s8 index) {
    void *dest[3];
    void *src[3];
    u32 size[3];

    memcpy(dest, sFontTileBufferVramDestinations, sizeof(dest));
    memset(src, 0, sizeof(src));
    memcpy(size, sFontTileBufferSizes, sizeof(size));

    if (index >= 0) {
        CpuFastCopy(src[index], dest[index], size[index]);
    }
}

/* Original address: 0x020185FC */
void mFont_FillTileBuffer(u8 value, s8 index) {
    void *dest[3];
    u32 size[3];
    u32 pixels;
    s32 i;

    memset(dest, 0, sizeof(dest));
    memcpy(size, sFontTileBufferSizes, sizeof(size));

    if (index >= 0) {
        pixels = 0;
        for (i = 0; i < 8; i++) {
            pixels |= (value & 0xF) << (i * 4);
        }
        CpuFastFill(pixels, dest[index], size[index]);
    }
}

/* Original address: 0x0201866C */
void mFont_BlitGlyphToTiles(mFont_GlyphDraw_c *glyph, s32 width) {
    s32 glyph_row;
    u16 y;
    s32 column;
    u16 x;
    u16 tile_index;
    u16 byte_offset;
    register u8 orig_pixels asm ("r0"); // @HACK - necessary to match
    u8 packed_pixels;

    for (glyph_row = 0, y = glyph->row; glyph_row < 8; glyph_row++, y++) {
        for (column = 0, x = glyph->tile_offset; column < width; column++, x++) {
            tile_index = (y >> 3) * glyph->tile_stride + (x >> 3);
            if ((glyph->glyph_upper_rows[glyph_row] >> column) & 1) {
                byte_offset = (tile_index << 5) + (y & 7) * 4 + ((x & 7) >> 1);
                orig_pixels = glyph->tile_data[byte_offset];
                packed_pixels = orig_pixels;
                if (x & 1) {
                    packed_pixels = (packed_pixels & 0xF) | ((glyph->palette & 0xF) << 4);
                } else {
                    packed_pixels = (packed_pixels & 0xF0) | (glyph->palette & 0xF);
                }
                glyph->tile_data[byte_offset] = packed_pixels;
            }

            tile_index += glyph->tile_stride;
            if ((glyph->glyph_lower_rows[glyph_row] >> column) & 1) {
                byte_offset = (tile_index << 5) + (y & 7) * 4 + ((x & 7) >> 1);
                orig_pixels = glyph->tile_data[byte_offset];
                packed_pixels = orig_pixels;
                if (x & 1) {
                    packed_pixels &= 0xF;
                    packed_pixels |= (glyph->palette & 0xF) << 4;
                } else {
                    packed_pixels &= 0xF0;
                    packed_pixels |= glyph->palette & 0xF;
                }
                glyph->tile_data[byte_offset] = packed_pixels;
            }
        }
    }
}

