#include "m_msg.h"
#include "global.h"
#define CHAR_CONTROL_CODE 0x7F
#define CHAR_SPACE_GBA    0x80
#define CHAR_NEW_LINE     0xCD

/* Original address: 0x02019BD0 */
extern const u8 sMsgGlyphWidths[256];

/* Original address: 0x02019CD0 */
extern const u8 sFontCodeWidths[256];

/* Original address: 0x02019DD0 */
extern const u8 sMsgFontGlyphs[16][2][16][8];

/* Original address: 0x0201ADD0 */
extern const u8 sMsgSpaceGlyph[2][8];

/* Original address: 0x02018348 */
void mFont_GetGlyphRows(void *lower_rows, void *upper_rows, u8 character) {
    union {
        u64 packed;
        u8 rows[8];
    } lower, upper;
    u8 *lower_dest;
    u32 glyph_offset;
    s32 i;

    lower.packed = *(u64 *)lower_rows;
    upper.packed = *(u64 *)upper_rows;

    if (character == CHAR_CONTROL_CODE || character == CHAR_SPACE_GBA ||
        character == CHAR_NEW_LINE) {
        *(u64 *)lower_rows = 0;
        *(u64 *)upper_rows = 0;
        return;
    }

    glyph_offset = ((character >> 4) * 32 + (character & 0xF)) * 8;
    lower_dest = lower.rows;
    for (i = 0; i < 8; i++) {
        if (character != 0x20) {
            upper.rows[i] = ((const u8 *)sMsgFontGlyphs)[glyph_offset + i];
            lower_dest[i] = ((const u8 *)sMsgFontGlyphs +
                             sizeof(sMsgFontGlyphs[0][0]))[glyph_offset + i];
        } else {
            upper.rows[i] = sMsgSpaceGlyph[0][i];
            lower_dest[i] = sMsgSpaceGlyph[1][i];
        }
    }

    *(u64 *)lower_rows = lower.packed;
    *(u64 *)upper_rows = upper.packed;
}

/* Original address: 0x020183F0 */
int mFont_GetGlyphWidth(u32 character) {
    if (character < 0x100) {
        return sMsgGlyphWidths[character];
    }
    return -1;
}

/* Original address: 0x0201840C */
int mFont_GetCodeWidth(u32 character) {
    if (character < 0x100) {
        return sFontCodeWidths[character];
    }
    return -1;
}
