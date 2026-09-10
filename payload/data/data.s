	.include "../asm/macros/function.inc"
	.include "../constants/gba_constants.inc"
	.data
	.syntax unified

	@ Canonical data begins at 0x02019B98 (file offset 0 in data.bin).
	.global sInitialIntrTable
sInitialIntrTable: @ 0x02019B98
	.4byte JoybootHandler
	.4byte VBlankInterruptHandler
	.4byte HBlankInterruptHandler
	.4byte VCountInterruptHandler
	.rept 10
	.4byte UnusedInterruptHandler
	.endr
	.global sMsgGlyphWidths
sMsgGlyphWidths: @ 0x02019BD0
	.incbin "data/data.bin", 0x0038, 0x0100
	.global sFontCodeWidths
sFontCodeWidths: @ 0x02019CD0
	.incbin "data/data.bin", 0x0138, 0x0100
	.global sMsgFontGlyphs
sMsgFontGlyphs: @ 0x02019DD0
	.incbin "data/data.bin", 0x0238, 0x1000
	.global sMsgSpaceGlyph
sMsgSpaceGlyph: @ 0x0201ADD0
	.incbin "data/data.bin", 0x1238, 0x0010
	.global sFontTileBufferVramDestinations
sFontTileBufferVramDestinations: @ 0x0201ADE0
	.incbin "data/data.bin", 0x1248, 0x000C
	.global sFontTileBufferSizes
sFontTileBufferSizes: @ 0x0201ADEC
	.incbin "data/data.bin", 0x1254, 0x000C
	.global sObjAffineSinTable
sObjAffineSinTable: @ 0x0201ADF8
	.incbin "data/data.bin", 0x1260, 0x0280
	.global sHiddenOamAttributes
sHiddenOamAttributes: @ 0x0201B078
	.incbin "data/data.bin", 0x14E0, 0x0008
	.global sGameModeProcs
sGameModeProcs: @ 0x0201B080
	.4byte InitializeIsland
	.4byte Game_Update
	.global sLoaderPalette2Current
sLoaderPalette2Current: @ 0x0201B088
	.incbin "data/data.bin", 0x14F0, 0x0010
	.global sLoaderPalette3Current
sLoaderPalette3Current: @ 0x0201B098
	.incbin "data/data.bin", 0x1500, 0x000C
	.global sJoybootGbaHandshake
sJoybootGbaHandshake: @ 0x0201B0A4
	.incbin "data/data.bin", 0x150C, 0x0008
	.global sJoybootGameCubeHandshake
sJoybootGameCubeHandshake: @ 0x0201B0AC
	.incbin "data/data.bin", 0x1514, 0x0008
	.global mMsg_null_sprite_profile
mMsg_null_sprite_profile: @ 0x0201B0B4
	.4byte 0, 0, 0, 0
	.global sMsgSpriteProfiles
sMsgSpriteProfiles: @ 0x0201B0C4
	.rept 12
	.4byte mMsg_null_sprite_profile
	.endr
	.4byte mMsg_loader_affine_sprite_profile
	.global mMsg_loader_affine_sprite_profile
mMsg_loader_affine_sprite_profile: @ 0x0201B0F8
	.4byte mMsg_LoaderAffineSpriteInit
	.4byte mMsg_LoaderAffineSpriteDestroy
	.4byte mMsg_LoaderAffineSpriteUpdate
	.4byte mMsg_LoaderAffineSpriteDraw

	@ 0x0201B108-0x0201B11F is m_msg_sprite.o(.rodata).
	.section .data.assets
sLoaderData_0201B120: @ 0x0201B120
	.incbin "data/data.bin", 0x1588, 0x00C0
	.global sLoaderBg0Tilemap
sLoaderBg0Tilemap: @ 0x0201B1E0
	.incbin "data/data.bin", 0x1648, 0x2000
	.global sLoaderBg2Tilemap
sLoaderBg2Tilemap: @ 0x0201D1E0
	.incbin "data/data.bin", 0x3648, 0x2000
	.global sLoaderBg3Tilemap
sLoaderBg3Tilemap: @ 0x0201F1E0
	.incbin "data/data.bin", 0x5648, 0x2850
	.global sLoaderObjTiles
sLoaderObjTiles: @ 0x02021A30
	.incbin "data/data.bin", 0x7E98, 0x8000
	.global sLoaderBgTiles
sLoaderBgTiles: @ 0x02029A30
	.incbin "data/data.bin", 0xFE98, 0x8000
	.global sLoaderBgPalette
sLoaderBgPalette: @ 0x02031A30
	.incbin "data/data.bin", 0x17E98, 0x0200
	.global sLoaderBg1Tilemap
sLoaderBg1Tilemap: @ 0x02031C30
	.incbin "data/data.bin", 0x18098, 0x2000
	.global sLoaderObjPalette
sLoaderObjPalette: @ 0x02033C30
	.incbin "data/data.bin", 0x1A098, 0x0204
