#ifndef M_MSG_UTIL_H
#define M_MSG_UTIL_H

#include "gba/types.h"

void mMsg_ReplaceChar(u8 *data, u8 from, u8 to, s32 length);
s32 mMsg_TrimTrailingSpaces(u8 *data, s32 length);
s32 mMsg_StringsDiffer(u8 *lhs, u8 *rhs, s32 length);
void mMsg_Copy(u8 *src, u8 *dest, s32 length);
void mMsg_Fill(u8 value, u8 *dest, s32 length);

#endif
