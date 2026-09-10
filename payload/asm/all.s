	.include "../asm/macros/function.inc"
	.include "../constants/gba_constants.inc"
	.text
	.syntax unified
	@ SDK_ONLY is used to assemble the shared compiler/runtime tail without
	@ duplicating the reconstructed C functions in the final link.
	.ifndef SDK_ONLY

	thumb_func_start AgbMain
AgbMain: @ 0x0201820C
	push {lr}
	bl sub_02018428
	bl sub_02019024
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_0201821C
sub_0201821C: @ 0x0201821C
	bx lr
	.align 2, 0

	thumb_func_start sub_02018220
sub_02018220: @ 0x02018220
	push {r4, r5, r6, lr}
	ldr r0, _0201831C @ =0x03000020
	ldr r1, _02018320 @ =0x0000085F
	adds r6, r0, r1
	ldrb r5, [r6]
	adds r4, r0, #0
	cmp r5, #0
	bne _020182FA
	ldr r0, _02018324 @ =0x030008E0
	movs r1, #0xe0
	lsls r1, r1, #0x13
	movs r2, #0x80
	lsls r2, r2, #1
	bl sub_02019A64
	movs r1, #0x80
	lsls r1, r1, #0x13
	ldr r2, _02018328 @ =0x0000082A
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #0x10
	adds r2, #0x12
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #0x34
	subs r2, #0x2e
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	subs r1, #4
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	subs r1, #0x48
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	adds r1, #2
	adds r2, #2
	adds r0, r4, r2
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r0, _0201832C @ =0x00000859
	adds r1, r4, r0
	ldrb r0, [r1]
	cmp r0, #1
	bne _020182EC
	strb r5, [r1]
_020182EC:
	ldr r1, _02018330 @ =0x0000085B
	adds r0, r4, r1
	ldrb r1, [r0]
	adds r1, #1
	strb r1, [r0]
	movs r0, #1
	strb r0, [r6]
_020182FA:
	ldr r2, _02018334 @ =0x04000202
	ldr r1, _02018338 @ =0x00000814
	adds r0, r4, r1
	ldrh r1, [r0]
	movs r1, #1
	strh r1, [r0]
	ldrh r0, [r0]
	strh r0, [r2]
	ldr r1, _0201833C @ =0x04000004
	movs r0, #8
	strh r0, [r1]
	bl sub_02018A20
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
_0201831C: .4byte 0x03000020
_02018320: .4byte 0x0000085F
_02018324: .4byte 0x030008E0
_02018328: .4byte 0x0000082A
_0201832C: .4byte 0x00000859
_02018330: .4byte 0x0000085B
_02018334: .4byte 0x04000202
_02018338: .4byte 0x00000814
_0201833C: .4byte 0x04000004

	thumb_func_start sub_02018340
sub_02018340: @ 0x02018340
	bx lr
	.align 2, 0

	thumb_func_start sub_02018344
sub_02018344: @ 0x02018344
	bx lr
	.align 2, 0

	thumb_func_start sub_02018348
sub_02018348: @ 0x02018348
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #0x10
	mov ip, r0
	mov r8, r1
	lsls r2, r2, #0x18
	ldr r1, [r0, #4]
	ldr r0, [r0]
	str r0, [sp]
	str r1, [sp, #4]
	mov r3, r8
	ldr r0, [r3]
	ldr r1, [r3, #4]
	str r0, [sp, #8]
	str r1, [sp, #0xc]
	lsrs r7, r2, #0x18
	movs r1, #0x81
	lsls r1, r1, #0x18
	adds r0, r2, r1
	lsrs r0, r0, #0x18
	cmp r0, #1
	bls _0201837A
	cmp r7, #0xcd
	bne _02018386
_0201837A:
	movs r0, #0
	movs r1, #0
	mov r2, ip
	str r0, [r2]
	str r1, [r2, #4]
	b _020183DE
_02018386:
	lsrs r1, r2, #0x1c
	lsls r1, r1, #5
	movs r0, #0xf
	ands r0, r7
	adds r1, r1, r0
	lsls r1, r1, #3
	ldr r2, _020183B0 @ =0x02019DD0
	mov r4, sp
	ldr r6, _020183B4 @ =0x0201ADD0
	add r3, sp, #8
	adds r0, r2, #0
	adds r0, #0x80
	adds r5, r1, r0
	adds r1, r1, r2
	movs r2, #7
_020183A4:
	cmp r7, #0x20
	beq _020183B8
	ldrb r0, [r1]
	strb r0, [r3]
	ldrb r0, [r5]
	b _020183BE
	.align 2, 0
_020183B0: .4byte 0x02019DD0
_020183B4: .4byte 0x0201ADD0
_020183B8:
	ldrb r0, [r6]
	strb r0, [r3]
	ldrb r0, [r6, #8]
_020183BE:
	strb r0, [r4]
	adds r4, #1
	adds r6, #1
	adds r3, #1
	adds r5, #1
	adds r1, #1
	subs r2, #1
	cmp r2, #0
	bge _020183A4
	ldr r0, [sp]
	ldr r1, [sp, #4]
	mov r2, ip
	str r0, [r2]
	str r1, [r2, #4]
	ldr r0, [sp, #8]
	ldr r1, [sp, #0xc]
_020183DE:
	mov r3, r8
	str r0, [r3]
	str r1, [r3, #4]
	add sp, #0x10
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0

	thumb_func_start sub_020183F0
sub_020183F0: @ 0x020183F0
	push {lr}
	adds r1, r0, #0
	cmp r1, #0xff
	bls _020183FE
	movs r0, #1
	rsbs r0, r0, #0
	b _02018404
_020183FE:
	ldr r0, _02018408 @ =0x02019BD0
	adds r0, r1, r0
	ldrb r0, [r0]
_02018404:
	pop {r1}
	bx r1
	.align 2, 0
_02018408: .4byte 0x02019BD0

	thumb_func_start sub_0201840C
sub_0201840C: @ 0x0201840C
	push {lr}
	adds r1, r0, #0
	cmp r1, #0xff
	bls _0201841A
	movs r0, #1
	rsbs r0, r0, #0
	b _02018420
_0201841A:
	ldr r0, _02018424 @ =0x02019CD0
	adds r0, r1, r0
	ldrb r0, [r0]
_02018420:
	pop {r1}
	bx r1
	.align 2, 0
_02018424: .4byte 0x02019CD0

	thumb_func_start sub_02018428
sub_02018428: @ 0x02018428
	push {lr}
	sub sp, #4
	movs r0, #0xc0
	bl sub_02019A6C
	movs r2, #0
	str r2, [sp]
	ldr r0, _02018488 @ =0x040000D4
	mov r1, sp
	str r1, [r0]
	movs r1, #0xc0
	lsls r1, r1, #0x12
	str r1, [r0, #4]
	ldr r1, _0201848C @ =0x85001E00
	str r1, [r0, #8]
	ldr r1, [r0, #8]
	str r2, [sp]
	mov r3, sp
	str r3, [r0]
	movs r1, #0xc0
	lsls r1, r1, #0x13
	str r1, [r0, #4]
	ldr r1, _02018490 @ =0x85006000
	str r1, [r0, #8]
	ldr r1, [r0, #8]
	ldr r2, _02018494 @ =0x04000204
	ldr r3, _02018498 @ =0x00004014
	adds r1, r3, #0
	strh r1, [r2]
	ldr r1, _0201849C @ =0x02019B98
	str r1, [r0]
	ldr r1, _020184A0 @ =0x03000890
	str r1, [r0, #4]
	ldr r1, _020184A4 @ =0x8000001C
	str r1, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _020184A8 @ =_intr
	str r1, [r0]
	ldr r2, _020184AC @ =0x03000034
	str r2, [r0, #4]
	ldr r1, _020184B0 @ =0x80000400
	str r1, [r0, #8]
	ldr r0, [r0, #8]
	ldr r0, _020184B4 @ =0x03007FFC
	str r2, [r0]
	add sp, #4
	pop {r0}
	bx r0
	.align 2, 0
_02018488: .4byte 0x040000D4
_0201848C: .4byte 0x85001E00
_02018490: .4byte 0x85006000
_02018494: .4byte 0x04000204
_02018498: .4byte 0x00004014
_0201849C: .4byte 0x02019B98
_020184A0: .4byte 0x03000890
_020184A4: .4byte 0x8000001C
_020184A8: .4byte _intr
_020184AC: .4byte 0x03000034
_020184B0: .4byte 0x80000400
_020184B4: .4byte 0x03007FFC

	thumb_func_start sub_020184B8
sub_020184B8: @ 0x020184B8
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x1c
	str r0, [sp, #0xc]
	mov sb, r1
	ldr r0, [sp, #0x44]
	ldr r1, [sp, #0x48]
	ldr r4, [sp, #0x4c]
	lsls r2, r2, #0x10
	lsls r3, r3, #0x10
	lsrs r3, r3, #0x10
	mov r8, r3
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	str r0, [sp, #0x10]
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	str r1, [sp, #0x14]
	lsls r4, r4, #0x18
	lsrs r4, r4, #0x18
	str r4, [sp, #0x18]
	movs r6, #0
	lsrs r0, r2, #0x13
	mov r1, r8
	muls r1, r0, r1
	adds r0, r1, #0
	lsls r0, r0, #5
	mov sl, r0
	movs r7, #0xe0
	lsls r7, r7, #0xb
	ands r7, r2
	b _02018520
_020184FE:
	str r4, [sp]
	ldr r3, [sp, #0x10]
	str r3, [sp, #4]
	subs r0, r5, #1
	str r0, [sp, #8]
	ldr r0, [sp, #0xc]
	add r0, sl
	adds r1, r2, #0
	lsrs r2, r7, #0x10
	mov r3, r8
	bl sub_0201856C
	mov r1, sb
	ldrh r0, [r1]
	adds r0, r0, r5
	strh r0, [r1]
	adds r6, #1
_02018520:
	ldr r3, [sp, #0x40]
	cmp r6, r3
	bge _0201855A
	ldr r1, [sp, #0x3c]
	adds r0, r1, r6
	ldrb r4, [r0]
	ldr r3, [sp, #0x14]
	cmp r3, #1
	bne _02018536
	cmp r4, #0xcd
	beq _0201855A
_02018536:
	cmp r4, #0x7f
	beq _0201855A
	ldr r0, [sp, #0x18]
	cmp r0, #1
	beq _0201854A
	adds r0, r4, #0
	bl sub_020183F0
	adds r5, r0, #0
	b _0201854C
_0201854A:
	movs r5, #8
_0201854C:
	mov r1, sb
	ldrh r2, [r1]
	adds r1, r5, r2
	mov r3, r8
	lsls r0, r3, #3
	cmp r1, r0
	ble _020184FE
_0201855A:
	adds r0, r6, #0
	add sp, #0x1c
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1

	thumb_func_start sub_0201856C
sub_0201856C: @ 0x0201856C
	push {r4, r5, r6, r7, lr}
	adds r6, r2, #0
	ldr r2, [sp, #0x14]
	ldr r5, [sp, #0x18]
	ldr r7, [sp, #0x1c]
	ldr r4, _020185A0 @ =0x03000E50
	str r0, [r4]
	strh r1, [r4, #4]
	strh r6, [r4, #6]
	strh r3, [r4, #8]
	strb r5, [r4, #0xe]
	adds r0, r4, #0
	adds r0, #0x10
	adds r1, r4, #0
	adds r1, #0x18
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	bl sub_02018348
	adds r0, r4, #0
	adds r1, r7, #0
	bl sub_0201866C
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
_020185A0: .4byte 0x03000E50

	thumb_func_start sub_020185A4
sub_020185A4: @ 0x020185A4
	push {r4, r5, r6, r7, lr}
	sub sp, #0x24
	adds r4, r0, #0
	lsls r4, r4, #0x18
	lsrs r4, r4, #0x18
	mov r1, sp
	ldr r0, _020185F4 @ =0x0201ADE0
	ldm r0!, {r2, r3, r5}
	stm r1!, {r2, r3, r5}
	add r5, sp, #0xc
	adds r0, r5, #0
	movs r1, #0
	movs r2, #0xc
	bl sub_02019B44
	add r3, sp, #0x18
	adds r1, r3, #0
	ldr r0, _020185F8 @ =0x0201ADEC
	ldm r0!, {r2, r6, r7}
	stm r1!, {r2, r6, r7}
	lsls r4, r4, #0x18
	asrs r2, r4, #0x18
	cmp r2, #0
	blt _020185EC
	lsls r2, r2, #2
	adds r0, r5, r2
	ldr r0, [r0]
	mov r4, sp
	adds r1, r4, r2
	ldr r1, [r1]
	adds r2, r3, r2
	ldr r2, [r2]
	lsls r2, r2, #9
	lsrs r2, r2, #0xb
	bl sub_02019A64
_020185EC:
	add sp, #0x24
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
_020185F4: .4byte 0x0201ADE0
_020185F8: .4byte 0x0201ADEC

	thumb_func_start sub_020185FC
sub_020185FC: @ 0x020185FC
	push {r4, r5, r6, r7, lr}
	sub sp, #0x1c
	adds r4, r1, #0
	lsls r0, r0, #0x18
	lsrs r6, r0, #0x18
	lsls r4, r4, #0x18
	lsrs r4, r4, #0x18
	mov r0, sp
	movs r1, #0
	movs r2, #0xc
	bl sub_02019B44
	add r2, sp, #0xc
	adds r1, r2, #0
	ldr r0, _02018668 @ =0x0201ADEC
	ldm r0!, {r3, r5, r7}
	stm r1!, {r3, r5, r7}
	lsls r0, r4, #0x18
	mov ip, r2
	cmp r0, #0
	blt _0201865E
	movs r4, #0
	movs r3, #0
	adds r5, r0, #0
	add r7, sp, #0x18
	movs r2, #0xf
	ands r2, r6
_02018632:
	lsls r1, r3, #2
	adds r0, r2, #0
	lsls r0, r1
	orrs r4, r0
	adds r3, #1
	cmp r3, #7
	ble _02018632
	str r4, [sp, #0x18]
	asrs r0, r5, #0x16
	mov r2, sp
	adds r1, r2, r0
	ldr r1, [r1]
	add r0, ip
	ldr r2, [r0]
	lsls r2, r2, #9
	lsrs r2, r2, #0xb
	movs r0, #0x80
	lsls r0, r0, #0x11
	orrs r2, r0
	adds r0, r7, #0
	bl sub_02019A64
_0201865E:
	add sp, #0x1c
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
_02018668: .4byte 0x0201ADEC

	thumb_func_start sub_0201866C
sub_0201866C: @ 0x0201866C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #0x10
	adds r3, r0, #0
	str r1, [sp]
	movs r0, #0
	str r0, [sp, #4]
	ldrh r1, [r3, #6]
	mov sb, r1
_02018684:
	movs r2, #0
	mov r8, r2
	ldrh r7, [r3, #4]
	ldr r5, [sp, #4]
	adds r5, #1
	str r5, [sp, #8]
	mov r0, sb
	adds r0, #1
	str r0, [sp, #0xc]
	ldr r1, [sp]
	cmp r8, r1
	bge _02018784
	mov r0, sb
	movs r2, #7
	ands r0, r2
	lsls r0, r0, #2
	mov sl, r0
	movs r5, #0xf
	mov ip, r5
_020186AA:
	mov r0, sb
	lsrs r1, r0, #3
	ldrh r0, [r3, #8]
	adds r2, r0, #0
	muls r2, r1, r2
	adds r0, r2, #0
	lsrs r1, r7, #3
	adds r0, r0, r1
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	adds r0, r3, #0
	adds r0, #0x18
	ldr r5, [sp, #4]
	adds r0, r0, r5
	ldrb r0, [r0]
	mov r1, r8
	asrs r0, r1
	movs r2, #1
	ands r0, r2
	cmp r0, #0
	beq _02018716
	lsls r1, r6, #5
	add r1, sl
	adds r0, r7, #0
	movs r5, #7
	ands r0, r5
	lsrs r0, r0, #1
	adds r1, r1, r0
	lsls r1, r1, #0x10
	lsrs r4, r1, #0x10
	ldr r1, [r3]
	adds r0, r1, r4
	ldrb r0, [r0]
	adds r2, r0, #0
	adds r0, r7, #0
	movs r5, #1
	ands r0, r5
	adds r5, r1, #0
	cmp r0, #0
	beq _02018706
	mov r0, ip
	ands r2, r0
	ldrb r1, [r3, #0xe]
	ands r0, r1
	lsls r0, r0, #4
	b _02018710
_02018706:
	movs r0, #0xf0
	ands r2, r0
	ldrb r1, [r3, #0xe]
	mov r0, ip
	ands r0, r1
_02018710:
	orrs r2, r0
	adds r0, r5, r4
	strb r2, [r0]
_02018716:
	ldrh r0, [r3, #8]
	adds r0, r6, r0
	lsls r0, r0, #0x10
	lsrs r6, r0, #0x10
	adds r0, r3, #0
	adds r0, #0x10
	ldr r1, [sp, #4]
	adds r0, r0, r1
	ldrb r0, [r0]
	mov r2, r8
	asrs r0, r2
	movs r5, #1
	ands r0, r5
	cmp r0, #0
	beq _02018774
	lsls r1, r6, #5
	add r1, sl
	adds r0, r7, #0
	movs r2, #7
	ands r0, r2
	lsrs r0, r0, #1
	adds r1, r1, r0
	lsls r1, r1, #0x10
	lsrs r4, r1, #0x10
	ldr r1, [r3]
	adds r0, r1, r4
	ldrb r0, [r0]
	adds r2, r0, #0
	adds r0, r7, #0
	ands r0, r5
	adds r5, r1, #0
	cmp r0, #0
	beq _02018764
	mov r0, ip
	ands r2, r0
	ldrb r1, [r3, #0xe]
	ands r0, r1
	lsls r0, r0, #4
	b _0201876E
_02018764:
	movs r0, #0xf0
	ands r2, r0
	ldrb r1, [r3, #0xe]
	mov r0, ip
	ands r0, r1
_0201876E:
	orrs r2, r0
	adds r0, r5, r4
	strb r2, [r0]
_02018774:
	movs r1, #1
	add r8, r1
	adds r0, r7, #1
	lsls r0, r0, #0x10
	lsrs r7, r0, #0x10
	ldr r2, [sp]
	cmp r8, r2
	blt _020186AA
_02018784:
	ldr r5, [sp, #8]
	str r5, [sp, #4]
	ldr r1, [sp, #0xc]
	lsls r0, r1, #0x10
	lsrs r0, r0, #0x10
	mov sb, r0
	cmp r5, #7
	bgt _02018796
	b _02018684
_02018796:
	add sp, #0x10
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_020187A8
sub_020187A8: @ 0x020187A8
	push {lr}
	lsls r0, r0, #0x10
	asrs r0, r0, #0x10
	lsls r1, r1, #0x10
	asrs r1, r1, #0x10
	muls r0, r1, r0
	cmp r0, #0
	bge _020187BA
	adds r0, #0xff
_020187BA:
	lsls r0, r0, #8
	asrs r0, r0, #0x10
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_020187C4
sub_020187C4: @ 0x020187C4
	push {lr}
	lsls r0, r0, #0x10
	asrs r0, r0, #8
	lsls r1, r1, #0x10
	asrs r1, r1, #0x10
	bl sub_02019AAC
	lsls r0, r0, #0x10
	asrs r0, r0, #0x10
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_020187DC
sub_020187DC: @ 0x020187DC
	adds r2, r0, #0
	ldr r1, [r2, #0xc]
	ldr r0, _020187F8 @ =0x41C64E6D
	muls r0, r1, r0
	ldr r3, _020187FC @ =0x0000085B
	adds r1, r2, r3
	ldrb r1, [r1]
	ldr r3, _02018800 @ =0x00003039
	adds r1, r1, r3
	adds r0, r0, r1
	str r0, [r2, #0xc]
	lsls r0, r0, #1
	lsrs r0, r0, #0x11
	bx lr
	.align 2, 0
_020187F8: .4byte 0x41C64E6D
_020187FC: .4byte 0x0000085B
_02018800: .4byte 0x00003039

	thumb_func_start sub_02018804
sub_02018804: @ 0x02018804
	str r1, [r0, #0xc]
	bx lr

	thumb_func_start sub_02018808
sub_02018808: @ 0x02018808
	push {r4, r5, lr}
	adds r5, r0, #0
	lsls r1, r1, #0x10
	lsrs r1, r1, #0x10
	lsls r2, r2, #0x10
	lsrs r4, r2, #0x10
	lsls r3, r3, #0x10
	lsrs r3, r3, #0x10
	cmp r1, #1
	bne _02018820
	movs r0, #0xc0
	b _02018822
_02018820:
	movs r0, #0x80
_02018822:
	movs r1, #0x82
	lsls r1, r1, #4
	adds r2, r5, r1
	adds r1, r4, #0
	orrs r1, r0
	strh r1, [r2]
	cmp r3, #0x10
	bls _02018834
	movs r3, #0x10
_02018834:
	ldr r1, _02018840 @ =0x0000081E
	adds r0, r5, r1
	strh r3, [r0]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
_02018840: .4byte 0x0000081E

	thumb_func_start sub_02018844
sub_02018844: @ 0x02018844
	push {r4, r5, lr}
	adds r5, r0, #0
	lsls r1, r1, #0x18
	lsrs r1, r1, #0x18
	lsls r2, r2, #0x18
	lsrs r2, r2, #0x18
	adds r4, r2, #0
	ldr r3, _0201886C @ =0x0000081E
	adds r0, r5, r3
	ldrh r3, [r0]
	cmp r1, #1
	bne _02018870
	adds r0, r3, r2
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	asrs r0, r0, #0x10
	cmp r0, #0x10
	ble _02018880
	movs r3, #0x10
	b _02018880
	.align 2, 0
_0201886C: .4byte 0x0000081E
_02018870:
	cmp r1, #0
	bne _02018880
	subs r0, r3, r4
	lsls r0, r0, #0x10
	lsrs r3, r0, #0x10
	cmp r0, #0
	bge _02018880
	movs r3, #0
_02018880:
	ldr r1, _02018890 @ =0x0000081E
	adds r0, r5, r1
	strh r3, [r0]
	ldrh r0, [r0]
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0
_02018890: .4byte 0x0000081E

	thumb_func_start sub_02018894
sub_02018894: @ 0x02018894
	push {r4, r5, r6, lr}
	ldr r6, [sp, #0x10]
	ldr r5, [sp, #0x14]
	movs r4, #0xf
	ands r2, r4
	ands r4, r1
	lsls r4, r4, #4
	adds r4, r4, r2
	lsls r4, r4, #1
	adds r4, r4, r0
	ldrh r1, [r4]
	lsrs r0, r1, #0xa
	movs r4, #0x1f
	movs r2, #0x1f
	ands r0, r2
	strb r0, [r5]
	lsrs r0, r1, #5
	ands r0, r2
	strb r0, [r6]
	ands r1, r4
	strb r1, [r3]
	pop {r4, r5, r6}
	pop {r0}
	bx r0

	thumb_func_start sub_020188C4
sub_020188C4: @ 0x020188C4
	push {r4, r5, r6, r7, lr}
	ldr r4, [sp, #0x14]
	ldr r5, [sp, #0x18]
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	lsls r1, r1, #0x18
	lsrs r6, r1, #0x18
	lsls r2, r2, #0x18
	lsrs r7, r2, #0x18
	lsls r3, r3, #0x18
	lsrs r3, r3, #0x18
	lsls r4, r4, #0x18
	lsrs r4, r4, #0x18
	lsls r5, r5, #0x18
	lsrs r1, r5, #0x18
	ldr r5, _0201891C @ =0x02038000
	cmp r0, #1
	bne _020188EA
	ldr r5, _02018920 @ =0x02038200
_020188EA:
	movs r2, #0x1f
	ands r1, r2
	lsls r1, r1, #0xa
	ands r4, r2
	lsls r0, r4, #5
	orrs r1, r0
	ands r3, r2
	orrs r3, r1
	movs r0, #0xf
	ands r6, r0
	ands r7, r0
	lsls r0, r6, #4
	adds r0, r0, r7
	lsls r0, r0, #1
	adds r0, r0, r5
	strh r3, [r0]
	ldr r0, _02018924 @ =0x03000020
	ldr r1, _02018928 @ =0x00000852
	adds r0, r0, r1
	movs r1, #1
	strb r1, [r0]
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
_0201891C: .4byte 0x02038000
_02018920: .4byte 0x02038200
_02018924: .4byte 0x03000020
_02018928: .4byte 0x00000852

	thumb_func_start sub_0201892C
sub_0201892C: @ 0x0201892C
	push {r4, lr}
	ldr r2, _0201896C @ =0x03000020
	ldr r0, _02018970 @ =0x00000814
	adds r3, r2, r0
	ldrh r1, [r3]
	ldr r0, _02018974 @ =0x0000FFFE
	ands r0, r1
	ldrh r1, [r3]
	strh r0, [r3]
	ldrh r1, [r3]
	movs r0, #1
	ands r0, r1
	adds r4, r2, #0
	cmp r0, #0
	bne _02018958
	adds r2, r3, #0
	movs r3, #1
_0201894E:
	ldrh r1, [r2]
	adds r0, r3, #0
	ands r0, r1
	cmp r0, #0
	beq _0201894E
_02018958:
	ldr r0, _02018970 @ =0x00000814
	adds r1, r4, r0
	ldrh r2, [r1]
	ldr r0, _02018974 @ =0x0000FFFE
	ands r0, r2
	ldrh r2, [r1]
	strh r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0201896C: .4byte 0x03000020
_02018970: .4byte 0x00000814
_02018974: .4byte 0x0000FFFE

	thumb_func_start sub_02018978
sub_02018978: @ 0x02018978
	push {r4, r5, lr}
	ldr r1, _020189A4 @ =0x030008E0
	movs r0, #0x80
	lsls r0, r0, #3
	adds r4, r1, r0
	ldr r5, _020189A8 @ =0x03000020
	cmp r1, r4
	bhs _02018994
	ldr r0, _020189AC @ =0x0201B078
	ldr r2, [r0]
	ldr r3, [r0, #4]
_0201898E:
	stm r1!, {r2, r3}
	cmp r1, r4
	blo _0201898E
_02018994:
	movs r0, #0x86
	lsls r0, r0, #4
	adds r1, r5, r0
	movs r0, #0
	strb r0, [r1]
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
_020189A4: .4byte 0x030008E0
_020189A8: .4byte 0x03000020
_020189AC: .4byte 0x0201B078

	thumb_func_start sub_020189B0
sub_020189B0: @ 0x020189B0
	push {r4, lr}
	ldr r0, _020189D8 @ =0x04000130
	ldrh r0, [r0]
	ldr r1, _020189DC @ =0x000003FF
	adds r2, r1, #0
	eors r2, r0
	ldr r1, _020189E0 @ =0x03000020
	ldr r3, _020189E4 @ =0x00000818
	adds r4, r1, r3
	ldrh r3, [r4]
	adds r0, r2, #0
	bics r0, r3
	ldr r3, _020189E8 @ =0x0000081A
	adds r1, r1, r3
	strh r0, [r1]
	strh r2, [r4]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_020189D8: .4byte 0x04000130
_020189DC: .4byte 0x000003FF
_020189E0: .4byte 0x03000020
_020189E4: .4byte 0x00000818
_020189E8: .4byte 0x0000081A

	thumb_func_start sub_020189EC
sub_020189EC: @ 0x020189EC
	ldr r2, _02018A10 @ =0x04000208
	movs r0, #0
	strh r0, [r2]
	movs r1, #0x80
	lsls r1, r1, #0x13
	movs r0, #0x80
	strh r0, [r1]
	adds r1, #4
	movs r0, #8
	strh r0, [r1]
	ldr r1, _02018A14 @ =0x04000200
	movs r0, #1
	strh r0, [r1]
	adds r1, #2
	strh r0, [r1]
	strh r0, [r2]
	bx lr
	.align 2, 0
_02018A10: .4byte 0x04000208
_02018A14: .4byte 0x04000200

	thumb_func_start sub_02018A18
sub_02018A18: @ 0x02018A18
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A1C
sub_02018A1C: @ 0x02018A1C
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A20
sub_02018A20: @ 0x02018A20
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A24
sub_02018A24: @ 0x02018A24
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A28
sub_02018A28: @ 0x02018A28
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A2C
sub_02018A2C: @ 0x02018A2C
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A30
sub_02018A30: @ 0x02018A30
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A34
sub_02018A34: @ 0x02018A34
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A38
sub_02018A38: @ 0x02018A38
	bx lr
	.align 2, 0

	thumb_func_start sub_02018A3C
sub_02018A3C: @ 0x02018A3C
	push {r4, r5, r6, lr}
	adds r6, r0, #0
	lsls r1, r1, #0x18
	lsrs r5, r1, #0x18
	lsls r2, r2, #0x18
	lsrs r4, r2, #0x18
	movs r2, #0
	cmp r3, #0
	ble _02018A62
	cmp r2, r3
	bge _02018A62
_02018A52:
	adds r1, r6, r2
	ldrb r0, [r1]
	cmp r0, r5
	bne _02018A5C
	strb r4, [r1]
_02018A5C:
	adds r2, #1
	cmp r2, r3
	blt _02018A52
_02018A62:
	pop {r4, r5, r6}
	pop {r0}
	bx r0

	thumb_func_start sub_02018A68
sub_02018A68: @ 0x02018A68
	push {lr}
	adds r3, r0, #0
	movs r2, #0
	cmp r1, #0
	ble _02018A90
	adds r2, r1, #0
	adds r0, r3, r2
	subs r0, #1
	ldrb r0, [r0]
	cmp r0, #0x80
	bne _02018A90
	subs r0, r2, #1
	adds r1, r0, r3
_02018A82:
	subs r1, #1
	subs r2, #1
	cmp r2, #0
	ble _02018A90
	ldrb r0, [r1]
	cmp r0, #0x80
	beq _02018A82
_02018A90:
	adds r0, r2, #0
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02018A98
sub_02018A98: @ 0x02018A98
	push {r4, r5, lr}
	adds r5, r0, #0
	adds r4, r1, #0
	movs r3, #0
	cmp r2, #0
	ble _02018AC2
	cmp r3, r2
	bge _02018AC2
	ldrb r0, [r5]
	ldrb r1, [r4]
	cmp r0, r1
	bne _02018AC2
_02018AB0:
	adds r3, #1
	cmp r3, r2
	bge _02018AC2
	adds r0, r5, r3
	adds r1, r4, r3
	ldrb r0, [r0]
	ldrb r1, [r1]
	cmp r0, r1
	beq _02018AB0
_02018AC2:
	adds r1, r3, #0
	eors r1, r2
	rsbs r0, r1, #0
	orrs r0, r1
	lsrs r0, r0, #0x1f
	pop {r4, r5}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02018AD4
sub_02018AD4: @ 0x02018AD4
	push {r4, r5, lr}
	adds r5, r0, #0
	adds r4, r1, #0
	cmp r2, #0
	ble _02018AF2
	movs r3, #0
	cmp r3, r2
	bge _02018AF2
_02018AE4:
	adds r0, r4, r3
	adds r1, r5, r3
	ldrb r1, [r1]
	strb r1, [r0]
	adds r3, #1
	cmp r3, r2
	blt _02018AE4
_02018AF2:
	pop {r4, r5}
	pop {r0}
	bx r0

	thumb_func_start sub_02018AF8
sub_02018AF8: @ 0x02018AF8
	push {r4, lr}
	adds r4, r1, #0
	lsls r0, r0, #0x18
	lsrs r1, r0, #0x18
	cmp r2, #0
	ble _02018B14
	movs r3, #0
	cmp r3, r2
	bge _02018B14
_02018B0A:
	adds r0, r4, r3
	strb r1, [r0]
	adds r3, #1
	cmp r3, r2
	blt _02018B0A
_02018B14:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0

	thumb_func_start sub_02018B1C
sub_02018B1C: @ 0x02018B1C
	push {lr}
	ldr r1, _02018B60 @ =0x03000020
	movs r0, #0x82
	lsls r0, r0, #4
	adds r2, r1, r0
	ldr r0, _02018B64 @ =0x00000441
	strh r0, [r2]
	ldr r0, _02018B68 @ =0x0000081C
	adds r1, r1, r0
	ldr r0, _02018B6C @ =0x00001008
	strh r0, [r1]
	ldr r0, _02018B70 @ =0x0201B088
	ldr r1, _02018B74 @ =0x05000190
	movs r2, #8
	bl sub_02019A68
	ldr r0, _02018B78 @ =0x0201B098
	ldr r1, _02018B7C @ =0x050001D6
	movs r2, #5
	bl sub_02019A68
	ldr r0, _02018B80 @ =0x02038180
	ldr r1, _02018B84 @ =0x05000180
	movs r2, #8
	bl sub_02019A64
	ldr r0, _02018B88 @ =0x020381C0
	ldr r1, _02018B8C @ =0x050001C0
	movs r2, #8
	bl sub_02019A64
	pop {r0}
	bx r0
	.align 2, 0
_02018B60: .4byte 0x03000020
_02018B64: .4byte 0x00000441
_02018B68: .4byte 0x0000081C
_02018B6C: .4byte 0x00001008
_02018B70: .4byte 0x0201B088
_02018B74: .4byte 0x05000190
_02018B78: .4byte 0x0201B098
_02018B7C: .4byte 0x050001D6
_02018B80: .4byte 0x02038180
_02018B84: .4byte 0x05000180
_02018B88: .4byte 0x020381C0
_02018B8C: .4byte 0x050001C0

	thumb_func_start sub_02018B90
sub_02018B90: @ 0x02018B90
	push {r4, r5, r6, lr}
	mov r6, sl
	mov r5, sb
	mov r4, r8
	push {r4, r5, r6}
	sub sp, #4
	bl sub_020189EC
	ldr r6, _02018CF8 @ =0x03000020
	ldr r1, _02018CFC @ =0x0000085F
	adds r0, r6, r1
	movs r2, #0
	mov sl, r2
	movs r1, #1
	strb r1, [r0]
	ldr r3, _02018D00 @ =0x00000858
	adds r0, r6, r3
	strb r1, [r0]
	ldr r1, _02018D04 @ =0x03000E40
	ldr r0, _02018D08 @ =0x0203B000
	str r0, [r1]
	ldr r0, _02018D0C @ =0x040000D4
	ldr r1, _02018D10 @ =0x02021A30
	str r1, [r0]
	ldr r1, _02018D14 @ =0x06010000
	str r1, [r0, #4]
	ldr r2, _02018D18 @ =0x84002000
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	mov r1, sp
	movs r4, #0
	mov ip, r4
	mov r5, sl
	strh r5, [r1]
	str r1, [r0]
	ldr r3, _02018D1C @ =0x02038000
	str r3, [r0, #4]
	ldr r1, _02018D20 @ =0x81000200
	str r1, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _02018D24 @ =0x02029A30
	str r1, [r0]
	movs r1, #0xc0
	lsls r1, r1, #0x13
	mov sb, r1
	str r1, [r0, #4]
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _02018D28 @ =0x02031A30
	str r1, [r0]
	str r3, [r0, #4]
	ldr r2, _02018D2C @ =0x80000100
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _02018D30 @ =0x02033C30
	str r1, [r0]
	ldr r1, _02018D34 @ =0x02038200
	str r1, [r0, #4]
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	str r3, [r0]
	movs r1, #0xa0
	lsls r1, r1, #0x13
	str r1, [r0, #4]
	ldr r1, _02018D38 @ =0x80000200
	str r1, [r0, #8]
	ldr r1, [r0, #8]
	ldr r2, _02018D3C @ =0x00000822
	adds r1, r6, r2
	movs r2, #0xdc
	lsls r2, r2, #8
	strh r2, [r1]
	ldr r3, _02018D40 @ =0x00000824
	adds r1, r6, r3
	ldr r3, _02018D44 @ =0x0000D801
	strh r3, [r1]
	ldr r4, _02018D48 @ =0x00000826
	adds r1, r6, r4
	ldr r4, _02018D4C @ =0x0000D402
	strh r4, [r1]
	ldr r5, _02018D50 @ =0x00000828
	adds r1, r6, r5
	ldr r5, _02018D54 @ =0x0000D003
	strh r5, [r1]
	ldr r1, _02018D58 @ =0x0201B1E0
	str r1, [r0]
	movs r1, #0xf8
	lsls r1, r1, #5
	mov r8, r1
	ands r2, r1
	lsls r2, r2, #3
	add r2, sb
	str r2, [r0, #4]
	ldr r2, _02018D5C @ =0x84000800
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _02018D60 @ =0x02031C30
	str r1, [r0]
	mov r1, r8
	ands r3, r1
	lsls r3, r3, #3
	add r3, sb
	str r3, [r0, #4]
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _02018D64 @ =0x0201D1E0
	str r1, [r0]
	mov r3, r8
	ands r4, r3
	lsls r4, r4, #3
	add r4, sb
	str r4, [r0, #4]
	str r2, [r0, #8]
	ldr r1, [r0, #8]
	ldr r1, _02018D68 @ =0x0201F1E0
	str r1, [r0]
	ands r5, r3
	lsls r5, r5, #3
	add r5, sb
	str r5, [r0, #4]
	str r2, [r0, #8]
	ldr r0, [r0, #8]
	ldr r4, _02018D6C @ =0x0000082A
	adds r1, r6, r4
	movs r0, #0xf0
	lsls r0, r0, #5
	strh r0, [r1]
	movs r5, #0x84
	lsls r5, r5, #4
	adds r0, r6, r5
	mov r1, sl
	strh r1, [r0]
	ldr r2, _02018D70 @ =0x00000842
	adds r0, r6, r2
	movs r1, #0x80
	lsls r1, r1, #1
	strh r1, [r0]
	ldr r3, _02018D74 @ =0x00000844
	adds r0, r6, r3
	mov r4, sl
	strh r4, [r0]
	adds r5, #6
	adds r0, r6, r5
	strh r1, [r0]
	mov r0, sl
	str r0, [r6]
	adds r2, #0x1a
	adds r1, r6, r2
	ldrb r0, [r1]
	adds r0, #1
	strb r0, [r1]
	adds r3, #0x1a
	adds r6, r6, r3
	mov r4, ip
	strb r4, [r6]
	bl sub_02019548
	movs r0, #0xc
	movs r1, #0x80
	movs r2, #0x50
	movs r3, #0
	bl sub_02019578
	ldr r0, _02018D78 @ =sub_0201866C
	ldr r1, _02018D7C @ =0x03000CE0
	movs r2, #0x58
	bl sub_02019A64
	bl sub_02019098
	bl sub_02018B1C
	add sp, #4
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
_02018CF8: .4byte 0x03000020
_02018CFC: .4byte 0x0000085F
_02018D00: .4byte 0x00000858
_02018D04: .4byte 0x03000E40
_02018D08: .4byte 0x0203B000
_02018D0C: .4byte 0x040000D4
_02018D10: .4byte 0x02021A30
_02018D14: .4byte 0x06010000
_02018D18: .4byte 0x84002000
_02018D1C: .4byte 0x02038000
_02018D20: .4byte 0x81000200
_02018D24: .4byte 0x02029A30
_02018D28: .4byte 0x02031A30
_02018D2C: .4byte 0x80000100
_02018D30: .4byte 0x02033C30
_02018D34: .4byte 0x02038200
_02018D38: .4byte 0x80000200
_02018D3C: .4byte 0x00000822
_02018D40: .4byte 0x00000824
_02018D44: .4byte 0x0000D801
_02018D48: .4byte 0x00000826
_02018D4C: .4byte 0x0000D402
_02018D50: .4byte 0x00000828
_02018D54: .4byte 0x0000D003
_02018D58: .4byte 0x0201B1E0
_02018D5C: .4byte 0x84000800
_02018D60: .4byte 0x02031C30
_02018D64: .4byte 0x0201D1E0
_02018D68: .4byte 0x0201F1E0
_02018D6C: .4byte 0x0000082A
_02018D70: .4byte 0x00000842
_02018D74: .4byte 0x00000844
_02018D78: .4byte sub_0201866C
_02018D7C: .4byte 0x03000CE0

	thumb_func_start sub_02018D80
sub_02018D80: @ 0x02018D80
	ldr r2, _02018D90 @ =0x03000E70
	str r1, [r2, #8]
	str r0, [r2]
	adds r2, #0x26
	movs r0, #1
	strb r0, [r2]
	bx lr
	.align 2, 0
_02018D90: .4byte 0x03000E70

	thumb_func_start sub_02018D94
sub_02018D94: @ 0x02018D94
	push {lr}
	movs r0, #0x80
	lsls r0, r0, #0x12
	ldr r1, _02018DC0 @ =0x04000208
	movs r2, #0
	strh r2, [r1]
	ldr r1, _02018DC4 @ =0x04000004
	strh r2, [r1]
	ldr r1, _02018DC8 @ =0x04000200
	strh r2, [r1]
	ldr r2, _02018DCC @ =0x04000202
	ldr r3, _02018DD0 @ =0x0000FFFF
	adds r1, r3, #0
	strh r1, [r2]
	movs r2, #0x80
	lsls r2, r2, #0x13
	movs r1, #0x80
	strh r1, [r2]
	bl sub_02019A70
	pop {r0}
	bx r0
	.align 2, 0
_02018DC0: .4byte 0x04000208
_02018DC4: .4byte 0x04000004
_02018DC8: .4byte 0x04000200
_02018DCC: .4byte 0x04000202
_02018DD0: .4byte 0x0000FFFF

	thumb_func_start sub_02018DD4
sub_02018DD4: @ 0x02018DD4
	push {r4, r5, r6, lr}
	bl sub_02019808
	ldr r0, _02018DF8 @ =0x03000020
	ldr r1, _02018DFC @ =0x0000085E
	adds r0, r0, r1
	ldrb r0, [r0]
	lsls r0, r0, #0x18
	asrs r0, r0, #0x18
	cmp r0, #7
	bls _02018DEC
	b _02018FCC
_02018DEC:
	lsls r0, r0, #2
	ldr r1, _02018E00 @ =_02018E04
	adds r0, r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_02018DF8: .4byte 0x03000020
_02018DFC: .4byte 0x0000085E
_02018E00: .4byte _02018E04
_02018E04: @ jump table
	.4byte _02018E24 @ case 0
	.4byte _02018E5C @ case 1
	.4byte _02018EB4 @ case 2
	.4byte _02018EEC @ case 3
	.4byte _02018FCC @ case 4
	.4byte _02018F60 @ case 5
	.4byte _02018FCC @ case 6
	.4byte _02018FB0 @ case 7
_02018E24:
	ldr r0, _02018E48 @ =0x03000E70
	ldr r1, [r0, #0x18]
	ldr r0, _02018E4C @ =0xFFFE0202
	cmp r1, r0
	beq _02018E30
	b _02019008
_02018E30:
	movs r0, #0x80
	lsls r0, r0, #0x12
	ldr r1, _02018E50 @ =0x00015244
	bl sub_02018D80
	ldr r0, _02018E54 @ =0x03000020
	ldr r2, _02018E58 @ =0x0000085E
	adds r0, r0, r2
	movs r1, #1
	strb r1, [r0]
	b _02019008
	.align 2, 0
_02018E48: .4byte 0x03000E70
_02018E4C: .4byte 0xFFFE0202
_02018E50: .4byte 0x00015244
_02018E54: .4byte 0x03000020
_02018E58: .4byte 0x0000085E
_02018E5C:
	ldr r0, _02018E7C @ =0x03000E70
	adds r1, r0, #0
	adds r1, #0x25
	ldrb r1, [r1]
	lsls r1, r1, #0x18
	asrs r1, r1, #0x18
	cmp r1, #0
	beq _02018E98
	cmp r1, #1
	bne _02018E88
	ldr r0, _02018E80 @ =0x03000020
	ldr r3, _02018E84 @ =0x0000085E
	adds r0, r0, r3
	movs r1, #2
	strb r1, [r0]
	b _02019008
	.align 2, 0
_02018E7C: .4byte 0x03000E70
_02018E80: .4byte 0x03000020
_02018E84: .4byte 0x0000085E
_02018E88:
	ldr r0, _02018E90 @ =0x03000020
	ldr r5, _02018E94 @ =0x0000085E
	adds r0, r0, r5
	b _02018F32
	.align 2, 0
_02018E90: .4byte 0x03000020
_02018E94: .4byte 0x0000085E
_02018E98:
	adds r0, #0x29
	ldrb r0, [r0]
	cmp r0, #0
	beq _02018EA2
	b _02019008
_02018EA2:
	ldr r0, _02018EAC @ =0x03000020
	ldr r6, _02018EB0 @ =0x0000085E
	adds r0, r0, r6
	b _02018F4E
	.align 2, 0
_02018EAC: .4byte 0x03000020
_02018EB0: .4byte 0x0000085E
_02018EB4:
	ldr r0, _02018ED8 @ =0x03000E70
	ldr r1, [r0, #0x18]
	ldr r0, _02018EDC @ =0xFFFE0202
	cmp r1, r0
	beq _02018EC0
	b _02019008
_02018EC0:
	ldr r0, _02018EE0 @ =0x03000E40
	ldr r0, [r0]
	movs r1, #0xe6
	lsls r1, r1, #6
	bl sub_02018D80
	ldr r0, _02018EE4 @ =0x03000020
	ldr r1, _02018EE8 @ =0x0000085E
	adds r0, r0, r1
	movs r1, #3
	strb r1, [r0]
	b _02019008
	.align 2, 0
_02018ED8: .4byte 0x03000E70
_02018EDC: .4byte 0xFFFE0202
_02018EE0: .4byte 0x03000E40
_02018EE4: .4byte 0x03000020
_02018EE8: .4byte 0x0000085E
_02018EEC:
	ldr r0, _02018F1C @ =0x03000E70
	adds r1, r0, #0
	adds r1, #0x25
	ldrb r1, [r1]
	lsls r1, r1, #0x18
	asrs r1, r1, #0x18
	cmp r1, #0
	beq _02018F40
	cmp r1, #1
	bne _02018F2C
	ldr r1, _02018F20 @ =0x03000020
	movs r2, #0x84
	lsls r2, r2, #4
	adds r0, r1, r2
	movs r2, #0
	strh r2, [r0]
	ldr r3, _02018F24 @ =0x00000842
	adds r0, r1, r3
	strh r2, [r0]
	ldr r5, _02018F28 @ =0x0000085E
	adds r1, r1, r5
	movs r0, #5
	strb r0, [r1]
	b _02019008
	.align 2, 0
_02018F1C: .4byte 0x03000E70
_02018F20: .4byte 0x03000020
_02018F24: .4byte 0x00000842
_02018F28: .4byte 0x0000085E
_02018F2C:
	ldr r0, _02018F38 @ =0x03000020
	ldr r6, _02018F3C @ =0x0000085E
	adds r0, r0, r6
_02018F32:
	movs r1, #4
	strb r1, [r0]
	b _02019008
	.align 2, 0
_02018F38: .4byte 0x03000020
_02018F3C: .4byte 0x0000085E
_02018F40:
	adds r0, #0x29
	ldrb r0, [r0]
	cmp r0, #0
	bne _02019008
	ldr r0, _02018F58 @ =0x03000020
	ldr r1, _02018F5C @ =0x0000085E
	adds r0, r0, r1
_02018F4E:
	movs r1, #4
	strb r1, [r0]
	bl sub_020194A0
	b _02019008
	.align 2, 0
_02018F58: .4byte 0x03000020
_02018F5C: .4byte 0x0000085E
_02018F60:
	ldr r4, _02018F9C @ =0x03000020
	ldr r2, _02018FA0 @ =0x0000081A
	adds r0, r4, r2
	ldrh r1, [r0]
	movs r0, #1
	ands r0, r1
	cmp r0, #0
	beq _02019008
	ldr r1, _02018FA4 @ =0x04000208
	ldrh r0, [r1]
	adds r3, r0, #0
	movs r0, #0
	strh r0, [r1]
	ldr r2, _02018FA8 @ =0x04000134
	movs r5, #0x80
	lsls r5, r5, #8
	adds r0, r5, #0
	strh r0, [r2]
	strh r3, [r1]
	adds r0, r4, #0
	movs r1, #0x80
	movs r2, #0x3f
	movs r3, #0
	bl sub_02018808
	ldr r6, _02018FAC @ =0x0000085E
	adds r1, r4, r6
	movs r0, #7
	strb r0, [r1]
	b _02019008
	.align 2, 0
_02018F9C: .4byte 0x03000020
_02018FA0: .4byte 0x0000081A
_02018FA4: .4byte 0x04000208
_02018FA8: .4byte 0x04000134
_02018FAC: .4byte 0x0000085E
_02018FB0:
	ldr r0, _02018FC8 @ =0x03000020
	movs r1, #1
	movs r2, #1
	bl sub_02018844
	lsls r0, r0, #0x10
	lsrs r0, r0, #0x10
	cmp r0, #0x10
	bne _02019008
	bl sub_02018D94
	b _02019008
	.align 2, 0
_02018FC8: .4byte 0x03000020
_02018FCC:
	ldr r4, _02019010 @ =0x03000020
	ldr r0, _02019014 @ =0x0000085E
	adds r5, r4, r0
	movs r0, #0
	ldrsb r0, [r5, r0]
	cmp r0, #4
	bne _02019008
	ldr r1, _02019018 @ =0x04000208
	ldrh r0, [r1]
	adds r3, r0, #0
	movs r0, #0
	strh r0, [r1]
	ldr r2, _0201901C @ =0x04000134
	movs r6, #0x80
	lsls r6, r6, #8
	adds r0, r6, #0
	strh r0, [r2]
	strh r3, [r1]
	movs r0, #0x84
	lsls r0, r0, #4
	adds r1, r4, r0
	movs r2, #0
	movs r0, #0x80
	lsls r0, r0, #1
	strh r0, [r1]
	ldr r1, _02019020 @ =0x00000842
	adds r0, r4, r1
	strh r2, [r0]
	movs r0, #9
	strb r0, [r5]
_02019008:
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
_02019010: .4byte 0x03000020
_02019014: .4byte 0x0000085E
_02019018: .4byte 0x04000208
_0201901C: .4byte 0x04000134
_02019020: .4byte 0x00000842

	thumb_func_start sub_02019024
sub_02019024: @ 0x02019024
	push {r4, r5, r6, r7, lr}
	sub sp, #4
	ldr r4, _0201906C @ =0x03000020
	ldr r7, _02019070 @ =0x0201B080
	ldr r0, _02019074 @ =0x0000085C
	adds r6, r4, r0
	ldr r1, _02019078 @ =0x0000085F
	adds r5, r4, r1
_02019034:
	bl sub_020189B0
	bl sub_02018978
	movs r1, #0x85
	lsls r1, r1, #4
	adds r0, r4, r1
	ldrb r0, [r0]
	cmp r0, #0
	bne _0201905A
	movs r0, #0
	ldrsb r0, [r6, r0]
	lsls r0, r0, #2
	adds r0, r0, r7
	ldr r0, [r0]
	cmp r0, #0
	beq _0201905A
	bl sub_02019A70
_0201905A:
	movs r0, #1
	bl sub_02019508
	movs r0, #0
	strb r0, [r5]
	bl sub_0201892C
	b _02019034
	.align 2, 0
_0201906C: .4byte 0x03000020
_02019070: .4byte 0x0201B080
_02019074: .4byte 0x0000085C
_02019078: .4byte 0x0000085F

	thumb_func_start sub_0201907C
sub_0201907C: @ 0x0201907C
	sub sp, #4
	mov r2, sp
	ldrb r1, [r0, #3]
	strb r1, [r2]
	ldrb r1, [r0, #2]
	strb r1, [r2, #1]
	ldrb r1, [r0, #1]
	strb r1, [r2, #2]
	mov r1, sp
	ldrb r0, [r0]
	strb r0, [r1, #3]
	ldr r0, [sp]
	add sp, #4
	bx lr

	thumb_func_start sub_02019098
sub_02019098: @ 0x02019098
	push {r4, r5, lr}
	sub sp, #4
	ldr r5, _020190E8 @ =0x04000208
	ldrh r4, [r5]
	movs r2, #0
	strh r2, [r5]
	ldr r1, _020190EC @ =0x04000134
	movs r3, #0xc0
	lsls r3, r3, #8
	adds r0, r3, #0
	strh r0, [r1]
	ldr r0, _020190F0 @ =0x04000158
	strh r2, [r0]
	subs r0, #8
	ldr r0, [r0]
	ldr r0, _020190F4 @ =0x04000154
	movs r3, #0
	str r3, [r0]
	adds r1, #0xc
	movs r0, #0x47
	strh r0, [r1]
	ldr r0, _020190F8 @ =0x04000202
	movs r1, #0x80
	strh r1, [r0]
	strh r1, [r0]
	ldr r2, _020190FC @ =0x04000200
	ldrh r0, [r2]
	orrs r0, r1
	strh r0, [r2]
	str r3, [sp]
	ldr r1, _02019100 @ =0x03000E70
	ldr r2, _02019104 @ =0x01000010
	mov r0, sp
	bl sub_02019A64
	strh r4, [r5]
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
_020190E8: .4byte 0x04000208
_020190EC: .4byte 0x04000134
_020190F0: .4byte 0x04000158
_020190F4: .4byte 0x04000154
_020190F8: .4byte 0x04000202
_020190FC: .4byte 0x04000200
_02019100: .4byte 0x03000E70
_02019104: .4byte 0x01000010

	thumb_func_start sub_02019108
sub_02019108: @ 0x02019108
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	sub sp, #8
	ldr r0, _02019140 @ =0x04000140
	ldrh r0, [r0]
	mov r8, r0
	movs r0, #1
	mov r1, r8
	ands r0, r1
	ldr r6, _02019144 @ =0x03000E70
	cmp r0, #0
	beq _0201915C
	adds r3, r6, #0
	adds r3, #0x29
	ldrb r2, [r3]
	cmp r2, #0
	bne _02019154
	ldr r0, _02019148 @ =0x04000150
	ldr r0, [r0]
	str r0, [sp, #4]
	ldr r1, _0201914C @ =0x04000154
	ldr r0, _02019150 @ =0x0201B0A4
	ldr r0, [r0]
	str r0, [r1]
	strb r2, [r3]
	b _0201915C
	.align 2, 0
_02019140: .4byte 0x04000140
_02019144: .4byte 0x03000E70
_02019148: .4byte 0x04000150
_0201914C: .4byte 0x04000154
_02019150: .4byte 0x0201B0A4
_02019154:
	movs r0, #2
	mov r1, r8
	orrs r1, r0
	mov r8, r1
_0201915C:
	movs r7, #2
	mov r0, r8
	ands r0, r7
	cmp r0, #0
	bne _02019168
	b _0201947A
_02019168:
	ldr r0, _020191A4 @ =0x04000150
	ldr r0, [r0]
	str r0, [sp, #4]
	adds r4, r6, #0
	adds r5, r4, #0
	adds r5, #0x29
	ldrb r2, [r5]
	cmp r2, #1
	beq _0201917C
	b _02019468
_0201917C:
	ldr r1, [r4, #0x18]
	ldr r0, _020191A8 @ =0xFFFE0105
	cmp r1, r0
	beq _020191BC
	cmp r1, r0
	bhi _020191AC
	subs r0, #3
	cmp r1, r0
	bls _02019190
	b _0201941C
_02019190:
	subs r0, #1
	cmp r1, r0
	bhs _02019198
	b _0201941C
_02019198:
	adds r0, r4, #0
	ldr r1, [r0, #8]
	cmp r1, #0
	bge _020191D4
	adds r1, #3
	b _020191D4
	.align 2, 0
_020191A4: .4byte 0x04000150
_020191A8: .4byte 0xFFFE0105
_020191AC:
	ldr r0, _020191B8 @ =0xFFFE0202
	cmp r1, r0
	bne _020191B4
	b _020192E8
_020191B4:
	b _0201941C
	.align 2, 0
_020191B8: .4byte 0xFFFE0202
_020191BC:
	ldr r0, _020191CC @ =0x04000154
	ldr r1, _020191D0 @ =0xFFFE0207
	str r1, [r0]
	movs r0, #0
	strb r0, [r5]
	str r0, [r4, #0x18]
	b _0201947A
	.align 2, 0
_020191CC: .4byte 0x04000154
_020191D0: .4byte 0xFFFE0207
_020191D4:
	asrs r1, r1, #2
	ldr r0, [r0, #4]
	cmp r0, r1
	ble _02019242
	ldr r2, _02019218 @ =0x03000E70
	adds r3, r2, #0
	adds r3, #0x24
	ldrb r5, [r3]
	movs r4, #0
	ldrsb r4, [r3, r4]
	cmp r4, #0
	beq _02019228
	ldr r0, _0201921C @ =0x04000158
	ldrh r1, [r0]
	movs r0, #8
	ands r0, r1
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	cmp r1, #0
	beq _020191FE
	b _0201947A
_020191FE:
	ldr r3, _02019220 @ =0xFFFE0209
	cmp r4, #1
	bne _02019206
	subs r3, #1
_02019206:
	ldr r0, _02019224 @ =0x04000154
	str r3, [r0]
	adds r0, r2, #0
	adds r0, #0x25
	strb r5, [r0]
	adds r0, #4
	strb r1, [r0]
	str r1, [r2, #0x18]
	b _0201947A
	.align 2, 0
_02019218: .4byte 0x03000E70
_0201921C: .4byte 0x04000158
_02019220: .4byte 0xFFFE0209
_02019224: .4byte 0x04000154
_02019228:
	ldr r1, _02019238 @ =0xFFFE0106
	ldr r0, [sp, #4]
	cmp r0, r1
	bne _0201923C
	movs r0, #1
	strb r0, [r3]
	b _0201947A
	.align 2, 0
_02019238: .4byte 0xFFFE0106
_0201923C:
	movs r0, #2
	strb r0, [r3]
	b _0201947A
_02019242:
	adds r3, r6, #0
	ldr r2, [r3, #0xc]
	cmp r2, #0
	blt _020192B8
	ldr r0, _02019274 @ =0x04000158
	ldrh r1, [r0]
	movs r0, #8
	ands r0, r1
	lsls r0, r0, #0x10
	lsrs r5, r0, #0x10
	cmp r5, #0
	beq _0201925C
	b _0201947A
_0201925C:
	ldr r0, [r3, #8]
	cmp r0, #0
	bge _02019264
	adds r0, #3
_02019264:
	asrs r0, r0, #2
	ldr r4, [r3, #4]
	cmp r4, r0
	bne _0201927C
	ldr r0, _02019278 @ =0x04000154
	ldr r1, [r3, #0x20]
	mvns r1, r1
	b _020192AA
	.align 2, 0
_02019274: .4byte 0x04000158
_02019278: .4byte 0x04000154
_0201927C:
	movs r0, #0xff
	ands r2, r0
	cmp r2, #0xff
	bne _02019294
	ldr r1, _02019290 @ =0x04000154
	ldr r0, [r3, #0x1c]
	mvns r0, r0
	str r0, [r1]
	str r5, [r3, #0x1c]
	b _020193CE
	.align 2, 0
_02019290: .4byte 0x04000154
_02019294:
	ldr r1, [r3]
	lsls r0, r4, #2
	adds r0, r0, r1
	ldr r1, [r0]
	ldr r0, [r3, #0x1c]
	adds r0, r0, r1
	str r0, [r3, #0x1c]
	ldr r0, [r3, #0x20]
	adds r0, r0, r1
	str r0, [r3, #0x20]
	ldr r0, _020192B4 @ =0x04000154
_020192AA:
	str r1, [r0]
	adds r0, r4, #1
	str r0, [r3, #4]
	b _020193CE
	.align 2, 0
_020192B4: .4byte 0x04000154
_020192B8:
	adds r0, r6, #0
	adds r0, #0x26
	ldrb r0, [r0]
	cmp r0, #1
	beq _020192C4
	b _0201940C
_020192C4:
	ldr r0, _020192DC @ =0x04000158
	ldrh r1, [r0]
	movs r0, #8
	ands r0, r1
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	cmp r2, #0
	beq _020192D6
	b _0201947A
_020192D6:
	ldr r1, _020192E0 @ =0x04000154
	ldr r0, _020192E4 @ =0xFFFE0204
	b _020193FA
	.align 2, 0
_020192DC: .4byte 0x04000158
_020192E0: .4byte 0x04000154
_020192E4: .4byte 0xFFFE0204
_020192E8:
	ldr r1, [r4, #8]
	cmp r1, #0
	bge _020192F0
	adds r1, #3
_020192F0:
	asrs r1, r1, #2
	ldr r0, [r4, #4]
	cmp r0, r1
	ble _02019354
	ldr r0, _02019320 @ =0x04000158
	ldrh r1, [r0]
	movs r0, #8
	ands r0, r1
	cmp r0, #0
	beq _02019306
	b _0201947A
_02019306:
	ldr r1, [r4, #0x20]
	movs r0, #1
	rsbs r0, r0, #0
	cmp r1, r0
	bne _0201932C
	ldr r0, _02019324 @ =0x04000154
	ldr r1, _02019328 @ =0xFFFE0208
	str r1, [r0]
	adds r0, r4, #0
	adds r0, #0x25
	strb r2, [r0]
	b _02019338
	.align 2, 0
_02019320: .4byte 0x04000158
_02019324: .4byte 0x04000154
_02019328: .4byte 0xFFFE0208
_0201932C:
	ldr r0, _02019348 @ =0x04000154
	ldr r1, _0201934C @ =0xFFFE0209
	str r1, [r0]
	adds r0, r4, #0
	adds r0, #0x25
	strb r7, [r0]
_02019338:
	ldr r1, _02019350 @ =0x03000E70
	adds r2, r1, #0
	adds r2, #0x29
	movs r0, #0
	strb r0, [r2]
	str r0, [r1, #0x18]
	b _0201947A
	.align 2, 0
_02019348: .4byte 0x04000154
_0201934C: .4byte 0xFFFE0209
_02019350: .4byte 0x03000E70
_02019354:
	ldr r0, [r4, #0xc]
	movs r5, #1
	rsbs r5, r5, #0
	cmp r0, r5
	ble _020193DC
	add r0, sp, #4
	bl sub_0201907C
	adds r3, r0, #0
	ldr r0, _02019394 @ =0x04000158
	ldrh r1, [r0]
	movs r0, #8
	ands r0, r1
	lsls r0, r0, #0x10
	lsrs r1, r0, #0x10
	cmp r1, #0
	beq _02019378
	b _0201947A
_02019378:
	ldr r0, [r4, #8]
	cmp r0, #0
	bge _02019380
	adds r0, #3
_02019380:
	asrs r0, r0, #2
	ldr r2, [r4, #4]
	cmp r2, r0
	bne _02019398
	ldr r1, [r4]
	lsls r0, r2, #2
	adds r0, r0, r1
	ldr r1, [sp, #4]
	str r1, [r0]
	b _020193C2
	.align 2, 0
_02019394: .4byte 0x04000158
_02019398:
	ldrb r0, [r4, #0xc]
	cmp r0, #0xff
	bne _020193B2
	ldr r0, [r4, #0x1c]
	adds r0, r0, r3
	str r0, [r4, #0x1c]
	cmp r0, r5
	beq _020193AE
	adds r0, r4, #0
	adds r0, #0x25
	strb r7, [r0]
_020193AE:
	str r1, [r4, #0x1c]
	b _020193CE
_020193B2:
	ldr r1, [r4]
	lsls r0, r2, #2
	adds r0, r0, r1
	ldr r1, [sp, #4]
	str r1, [r0]
	ldr r0, [r4, #0x1c]
	adds r0, r0, r3
	str r0, [r4, #0x1c]
_020193C2:
	ldr r0, [r4, #0x20]
	adds r0, r0, r3
	str r0, [r4, #0x20]
	ldr r0, [r4, #4]
	adds r0, #1
	str r0, [r4, #4]
_020193CE:
	ldr r1, _020193D8 @ =0x03000E70
	ldr r0, [r1, #0xc]
	adds r0, #1
	str r0, [r1, #0xc]
	b _0201947A
	.align 2, 0
_020193D8: .4byte 0x03000E70
_020193DC:
	adds r0, r6, #0
	adds r0, #0x26
	ldrb r0, [r0]
	cmp r0, #1
	bne _0201940C
	ldr r0, _02019400 @ =0x04000158
	ldrh r1, [r0]
	movs r0, #8
	ands r0, r1
	lsls r0, r0, #0x10
	lsrs r2, r0, #0x10
	cmp r2, #0
	bne _0201947A
	ldr r1, _02019404 @ =0x04000154
	ldr r0, _02019408 @ =0xFFFE0104
_020193FA:
	str r0, [r1]
	str r2, [r6, #0xc]
	b _0201947A
	.align 2, 0
_02019400: .4byte 0x04000158
_02019404: .4byte 0x04000154
_02019408: .4byte 0xFFFE0104
_0201940C:
	ldr r1, _02019414 @ =0x04000154
	ldr r0, _02019418 @ =0xFFFE0205
	str r0, [r1]
	b _0201947A
	.align 2, 0
_02019414: .4byte 0x04000154
_02019418: .4byte 0xFFFE0205
_0201941C:
	ldr r4, _02019458 @ =0x03000E70
	ldr r1, [sp, #4]
	str r1, [r4, #0x18]
	ldr r0, _0201945C @ =0xFFFE0101
	cmp r1, r0
	blo _0201947A
	adds r0, #1
	cmp r1, r0
	bls _02019434
	ldr r0, _02019460 @ =0xFFFE0202
	cmp r1, r0
	bne _0201947A
_02019434:
	movs r0, #0
	str r0, [sp]
	ldr r2, _02019464 @ =0x01000010
	mov r0, sp
	adds r1, r4, #0
	bl sub_02019A64
	movs r0, #1
	rsbs r0, r0, #0
	str r0, [r4, #0xc]
	ldr r0, [sp, #4]
	str r0, [r4, #0x18]
	adds r1, r4, #0
	adds r1, #0x29
	movs r0, #1
	strb r0, [r1]
	b _0201947A
	.align 2, 0
_02019458: .4byte 0x03000E70
_0201945C: .4byte 0xFFFE0101
_02019460: .4byte 0xFFFE0202
_02019464: .4byte 0x01000010
_02019468:
	add r0, sp, #4
	bl sub_0201907C
	ldr r1, _02019494 @ =0x0201B0AC
	ldr r1, [r1]
	cmp r0, r1
	bne _0201947A
	movs r0, #1
	strb r0, [r5]
_0201947A:
	ldr r0, _02019498 @ =0x04000140
	mov r1, r8
	strh r1, [r0]
	ldr r0, _0201949C @ =0x03000E70
	adds r0, #0x2a
	movs r1, #0
	strb r1, [r0]
	add sp, #8
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
_02019494: .4byte 0x0201B0AC
_02019498: .4byte 0x04000140
_0201949C: .4byte 0x03000E70

	thumb_func_start sub_020194A0
sub_020194A0: @ 0x020194A0
	push {r4, r5, lr}
	sub sp, #4
	ldr r5, _020194F0 @ =0x04000208
	ldrh r4, [r5]
	movs r2, #0
	strh r2, [r5]
	ldr r1, _020194F4 @ =0x04000134
	movs r3, #0x80
	lsls r3, r3, #8
	adds r0, r3, #0
	strh r0, [r1]
	movs r3, #0xc0
	lsls r3, r3, #8
	adds r0, r3, #0
	strh r0, [r1]
	ldr r0, _020194F8 @ =0x04000158
	strh r2, [r0]
	subs r0, #8
	ldr r0, [r0]
	ldr r0, _020194FC @ =0x04000154
	movs r2, #0
	str r2, [r0]
	adds r1, #0xc
	movs r0, #0x47
	strh r0, [r1]
	adds r1, #0xc2
	movs r0, #0x80
	strh r0, [r1]
	str r2, [sp]
	ldr r1, _02019500 @ =0x03000E70
	ldr r2, _02019504 @ =0x01000010
	mov r0, sp
	bl sub_02019A64
	strh r4, [r5]
	add sp, #4
	pop {r4, r5}
	pop {r0}
	bx r0
	.align 2, 0
_020194F0: .4byte 0x04000208
_020194F4: .4byte 0x04000134
_020194F8: .4byte 0x04000158
_020194FC: .4byte 0x04000154
_02019500: .4byte 0x03000E70
_02019504: .4byte 0x01000010

	thumb_func_start sub_02019508
sub_02019508: @ 0x02019508
	push {r4, lr}
	lsls r0, r0, #0x18
	lsrs r3, r0, #0x18
	movs r2, #0
	ldr r0, _0201952C @ =0x03000E70
	adds r4, r0, #0
	adds r4, #0x2a
	ldrb r1, [r4]
	cmp r1, #0xa
	bhi _02019534
	ldr r0, _02019530 @ =0x04000208
	strh r2, [r0]
	adds r1, #1
	strb r1, [r4]
	movs r1, #1
	strh r1, [r0]
	b _0201953E
	.align 2, 0
_0201952C: .4byte 0x03000E70
_02019530: .4byte 0x04000208
_02019534:
	cmp r3, #0
	beq _0201953C
	bl sub_020194A0
_0201953C:
	movs r2, #1
_0201953E:
	adds r0, r2, #0
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02019548
sub_02019548: @ 0x02019548
	push {lr}
	sub sp, #4
	movs r0, #0
	str r0, [sp]
	ldr r1, _02019560 @ =0x03000EB0
	ldr r2, _02019564 @ =0x01000120
	mov r0, sp
	bl sub_02019A64
	add sp, #4
	pop {r0}
	bx r0
	.align 2, 0
_02019560: .4byte 0x03000EB0
_02019564: .4byte 0x01000120

	thumb_func_start sub_02019568
sub_02019568: @ 0x02019568
	adds r2, r0, #0
	adds r2, #0x57
	movs r1, #0
	strb r1, [r2]
	str r1, [r0, #8]
	str r1, [r0, #0xc]
	bx lr
	.align 2, 0

	thumb_func_start sub_02019578
sub_02019578: @ 0x02019578
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	sub sp, #8
	mov sb, r1
	mov sl, r2
	str r3, [sp, #4]
	lsls r0, r0, #0x18
	lsrs r0, r0, #0x18
	mov r8, r0
	movs r4, #0
	movs r0, #0
	bl sub_02019630
	adds r2, r0, #0
	cmp r2, #0
	blt _02019612
	ldr r1, _02019624 @ =0x0201B0C4
	mov r3, r8
	lsls r0, r3, #2
	adds r0, r0, r1
	ldr r5, [r0]
	str r4, [sp]
	lsls r4, r2, #1
	adds r4, r4, r2
	lsls r4, r4, #5
	ldr r6, _02019628 @ =0x03000EB0
	adds r7, r4, r6
	ldr r2, _0201962C @ =0x01000018
	mov r0, sp
	adds r1, r7, #0
	bl sub_02019A64
	ldr r0, [r5]
	str r0, [r7]
	adds r0, r6, #4
	adds r0, r4, r0
	ldr r1, [r5, #4]
	str r1, [r0]
	adds r0, r6, #0
	adds r0, #8
	adds r0, r4, r0
	ldr r1, [r5, #8]
	str r1, [r0]
	adds r0, r6, #0
	adds r0, #0xc
	adds r0, r4, r0
	ldr r1, [r5, #0xc]
	str r1, [r0]
	adds r0, r7, #0
	adds r0, #0x57
	mov r1, r8
	strb r1, [r0]
	adds r0, r6, #0
	adds r0, #0x2c
	adds r0, r4, r0
	mov r3, sb
	str r3, [r0]
	adds r0, r6, #0
	adds r0, #0x30
	adds r0, r4, r0
	mov r1, sl
	str r1, [r0]
	adds r0, r6, #0
	adds r0, #0x14
	adds r4, r4, r0
	ldr r3, [sp, #4]
	str r3, [r4]
	ldr r1, [r7]
	cmp r1, #0
	beq _02019610
	adds r0, r7, #0
	bl sub_02019A74
_02019610:
	adds r4, r7, #0
_02019612:
	adds r0, r4, #0
	add sp, #8
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0
_02019624: .4byte 0x0201B0C4
_02019628: .4byte 0x03000EB0
_0201962C: .4byte 0x01000018

	thumb_func_start sub_02019630
sub_02019630: @ 0x02019630
	push {lr}
	lsls r0, r0, #0x18
	lsrs r3, r0, #0x18
	movs r2, #0
	ldr r0, _02019640 @ =0x03000EB0
	adds r1, r0, #0
	adds r1, #0x57
	b _0201964C
	.align 2, 0
_02019640: .4byte 0x03000EB0
_02019644:
	adds r1, #0x60
	adds r2, #1
	cmp r2, #0xb
	bgt _02019652
_0201964C:
	ldrb r0, [r1]
	cmp r0, r3
	bne _02019644
_02019652:
	adds r0, r2, #0
	cmp r0, #0xb
	ble _0201965C
	movs r0, #1
	rsbs r0, r0, #0
_0201965C:
	pop {r1}
	bx r1

	thumb_func_start sub_02019660
sub_02019660: @ 0x02019660
	push {r4, lr}
	adds r2, r0, #0
	movs r3, #0
	movs r4, #0x38
	ldrsh r0, [r2, r4]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r1, [r0]
	movs r4, #0x34
	ldrsh r0, [r2, r4]
	cmp r0, #0
	bne _02019688
	movs r4, #0x36
	ldrsh r0, [r2, r4]
	lsls r0, r0, #3
	adds r0, r0, r1
	ldr r0, [r0, #8]
	cmp r0, #0
	bne _02019688
	movs r3, #1
_02019688:
	adds r0, r3, #0
	pop {r4}
	pop {r1}
	bx r1

	thumb_func_start sub_02019690
sub_02019690: @ 0x02019690
	push {r4, lr}
	movs r3, #0
	strh r2, [r0, #0x38]
	movs r4, #0x38
	ldrsh r2, [r0, r4]
	lsls r2, r2, #2
	adds r2, r2, r1
	ldr r1, [r2]
	ldrh r1, [r1, #4]
	strh r1, [r0, #0x34]
	strh r3, [r0, #0x36]
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start sub_020196AC
sub_020196AC: @ 0x020196AC
	push {lr}
	adds r2, r0, #0
	movs r3, #0x38
	ldrsh r0, [r2, r3]
	lsls r0, r0, #2
	adds r0, r0, r1
	ldr r3, [r0]
	movs r1, #0x34
	ldrsh r0, [r2, r1]
	subs r0, #1
	cmp r0, #0
	bgt _020196EE
	movs r1, #0x36
	ldrsh r0, [r2, r1]
	lsls r0, r0, #3
	adds r0, r0, r3
	ldr r1, [r0, #8]
	cmp r1, #0
	bne _020196DC
	ldrb r0, [r0, #6]
	cmp r0, #0
	beq _020196F2
	strh r1, [r2, #0x36]
	b _020196E2
_020196DC:
	ldrh r0, [r2, #0x36]
	adds r0, #1
	strh r0, [r2, #0x36]
_020196E2:
	movs r1, #0x36
	ldrsh r0, [r2, r1]
	lsls r0, r0, #3
	adds r0, r0, r3
	ldrh r0, [r0, #4]
	b _020196F2
_020196EE:
	ldrh r0, [r2, #0x34]
	subs r0, #1
_020196F2:
	strh r0, [r2, #0x34]
	pop {r0}
	bx r0

	thumb_func_start sub_020196F8
sub_020196F8: @ 0x020196F8
	push {r4, r5, r6, lr}
	mov r6, sb
	mov r5, r8
	push {r5, r6}
	ldr r3, [r0, #0x30]
	ldrb r4, [r1]
	adds r4, r4, r3
	ldr r3, [r0, #0x24]
	adds r3, r3, r4
	strb r3, [r2]
	ldrb r3, [r1, #1]
	lsls r3, r3, #0x1e
	lsrs r3, r3, #0x1e
	ldrb r5, [r2, #1]
	movs r4, #4
	rsbs r4, r4, #0
	ands r4, r5
	orrs r4, r3
	strb r4, [r2, #1]
	ldrb r5, [r1, #1]
	movs r3, #0xc
	ands r3, r5
	movs r5, #0xd
	rsbs r5, r5, #0
	mov sb, r5
	ands r5, r4
	orrs r5, r3
	strb r5, [r2, #1]
	ldrb r4, [r1, #1]
	movs r3, #0x10
	ands r3, r4
	movs r4, #0x11
	rsbs r4, r4, #0
	mov r8, r4
	mov r6, r8
	ands r6, r5
	orrs r6, r3
	strb r6, [r2, #1]
	ldrb r3, [r1, #1]
	movs r4, #0x20
	ands r4, r3
	movs r5, #0x21
	rsbs r5, r5, #0
	adds r3, r5, #0
	ands r3, r6
	orrs r3, r4
	strb r3, [r2, #1]
	ldrb r4, [r1, #1]
	lsrs r4, r4, #6
	lsls r4, r4, #6
	movs r6, #0x3f
	ands r3, r6
	orrs r3, r4
	strb r3, [r2, #1]
	ldrh r3, [r1, #2]
	lsls r3, r3, #0x17
	lsrs r3, r3, #0x17
	ldr r4, [r0, #0x2c]
	adds r3, r3, r4
	ldr r0, [r0, #0x20]
	adds r3, r3, r0
	ldr r4, _020197FC @ =0x000001FF
	adds r0, r4, #0
	ands r3, r0
	ldrh r4, [r2, #2]
	ldr r0, _02019800 @ =0xFFFFFE00
	ands r0, r4
	orrs r0, r3
	strh r0, [r2, #2]
	ldrb r3, [r1, #3]
	movs r0, #0xe
	ands r0, r3
	ldrb r4, [r2, #3]
	movs r3, #0xf
	rsbs r3, r3, #0
	ands r3, r4
	orrs r3, r0
	strb r3, [r2, #3]
	ldrb r4, [r1, #3]
	movs r0, #0x10
	ands r0, r4
	mov r4, r8
	ands r4, r3
	orrs r4, r0
	strb r4, [r2, #3]
	ldrb r3, [r1, #3]
	movs r0, #0x20
	ands r0, r3
	ands r5, r4
	orrs r5, r0
	strb r5, [r2, #3]
	ldrb r0, [r1, #3]
	lsrs r0, r0, #6
	lsls r0, r0, #6
	ands r5, r6
	orrs r5, r0
	strb r5, [r2, #3]
	ldrh r3, [r1, #4]
	lsls r3, r3, #0x16
	lsrs r3, r3, #0x16
	ldrh r4, [r2, #4]
	ldr r0, _02019804 @ =0xFFFFFC00
	ands r0, r4
	orrs r0, r3
	strh r0, [r2, #4]
	ldrb r3, [r1, #5]
	movs r0, #0xc
	ands r0, r3
	ldrb r3, [r2, #5]
	mov r5, sb
	ands r5, r3
	orrs r5, r0
	mov sb, r5
	strb r5, [r2, #5]
	ldrb r0, [r1, #5]
	lsrs r0, r0, #4
	lsls r0, r0, #4
	movs r3, #0xf
	mov r4, sb
	ands r4, r3
	orrs r4, r0
	strb r4, [r2, #5]
	ldrh r0, [r1, #6]
	strh r0, [r2, #6]
	pop {r3, r4}
	mov r8, r3
	mov sb, r4
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
_020197FC: .4byte 0x000001FF
_02019800: .4byte 0xFFFFFE00
_02019804: .4byte 0xFFFFFC00

	thumb_func_start sub_02019808
sub_02019808: @ 0x02019808
	push {r4, r5, r6, lr}
	ldr r0, _0201985C @ =0x03000EB0
	adds r6, r0, #0
	adds r6, #0x57
	adds r4, r0, #0
	movs r5, #0xb
_02019814:
	ldrb r0, [r6]
	cmp r0, #0
	beq _02019826
	ldr r1, [r4, #8]
	cmp r1, #0
	beq _02019826
	adds r0, r4, #0
	bl sub_02019A74
_02019826:
	adds r6, #0x60
	adds r4, #0x60
	subs r5, #1
	cmp r5, #0
	bge _02019814
	ldr r0, _0201985C @ =0x03000EB0
	adds r6, r0, #0
	adds r6, #0x57
	adds r4, r0, #0
	movs r5, #0xb
_0201983A:
	ldrb r0, [r6]
	cmp r0, #0
	beq _0201984C
	ldr r1, [r4, #0xc]
	cmp r1, #0
	beq _0201984C
	adds r0, r4, #0
	bl sub_02019A74
_0201984C:
	adds r6, #0x60
	adds r4, #0x60
	subs r5, #1
	cmp r5, #0
	bge _0201983A
	pop {r4, r5, r6}
	pop {r0}
	bx r0
	.align 2, 0
_0201985C: .4byte 0x03000EB0

	thumb_func_start sub_02019860
sub_02019860: @ 0x02019860
	push {r4, lr}
	lsls r2, r2, #2
	adds r2, r2, r1
	ldr r2, [r2]
	adds r1, r0, #0
	adds r1, #0x42
	adds r1, r1, r3
	ldrh r2, [r2, #4]
	movs r4, #0
	strb r2, [r1]
	adds r0, #0x4c
	adds r0, r0, r3
	strb r4, [r0]
	pop {r4}
	pop {r0}
	bx r0

	thumb_func_start sub_02019880
sub_02019880: @ 0x02019880
	push {r4, r5, r6, r7, lr}
	mov r7, r8
	push {r7}
	adds r7, r0, #0
	adds r4, r2, #0
	lsls r0, r4, #2
	adds r0, r0, r1
	ldr r0, [r0]
	mov r8, r0
	adds r0, r7, #0
	adds r0, #0x42
	adds r2, r0, r4
	movs r0, #0
	ldrsb r0, [r2, r0]
	subs r0, #1
	cmp r0, #0
	bgt _020198EC
	adds r1, r7, #0
	adds r1, #0x4c
	adds r3, r1, r4
	movs r0, #0
	ldrsb r0, [r3, r0]
	lsls r0, r0, #3
	add r0, r8
	adds r5, r0, #0
	adds r5, #8
	ldr r6, [r0, #8]
	mov ip, r1
	cmp r6, #0
	bne _020198CC
	ldrb r0, [r5, #6]
	cmp r0, #0
	beq _020198C6
	strb r6, [r3]
	b _020198D2
_020198C6:
	strb r0, [r2]
	movs r0, #1
	b _020198F4
_020198CC:
	ldrb r0, [r3]
	adds r0, #1
	strb r0, [r3]
_020198D2:
	adds r1, r7, #0
	adds r1, #0x42
	adds r1, r1, r4
	mov r2, ip
	adds r0, r2, r4
	ldrb r0, [r0]
	lsls r0, r0, #0x18
	asrs r0, r0, #0x18
	lsls r0, r0, #3
	add r0, r8
	ldrh r0, [r0, #4]
	strb r0, [r1]
	b _020198F2
_020198EC:
	ldrb r0, [r2]
	subs r0, #1
	strb r0, [r2]
_020198F2:
	movs r0, #0
_020198F4:
	pop {r3}
	mov r8, r3
	pop {r4, r5, r6, r7}
	pop {r1}
	bx r1
	.align 2, 0

	thumb_func_start sub_02019900
sub_02019900: @ 0x02019900
	push {r4, lr}
	adds r3, r0, #0
	lsls r0, r2, #2
	adds r0, r0, r1
	ldr r4, [r0]
	adds r0, r3, #0
	adds r0, #0x42
	adds r1, r0, r2
	movs r0, #0
	ldrsb r0, [r1, r0]
	subs r0, #1
	cmp r0, #0
	bgt _0201993E
	adds r0, r3, #0
	adds r0, #0x4c
	adds r2, r0, r2
	ldrb r3, [r2]
	movs r0, #0
	ldrsb r0, [r2, r0]
	cmp r0, #0
	bne _0201992E
	movs r0, #1
	b _02019946
_0201992E:
	subs r0, r3, #1
	strb r0, [r2]
	movs r0, #0
	ldrsb r0, [r2, r0]
	lsls r0, r0, #3
	adds r0, r0, r4
	ldrh r0, [r0, #4]
	b _02019942
_0201993E:
	ldrb r0, [r1]
	subs r0, #1
_02019942:
	strb r0, [r1]
	movs r0, #0
_02019946:
	pop {r4}
	pop {r1}
	bx r1

	thumb_func_start sub_0201994C
sub_0201994C: @ 0x0201994C
	push {r4, r5, r6, r7, lr}
	mov r7, sl
	mov r6, sb
	mov r5, r8
	push {r5, r6, r7}
	mov r8, r0
	adds r5, r1, #0
	adds r4, r2, #0
	adds r6, r3, #0
	lsls r5, r5, #0x10
	lsrs r5, r5, #0x10
	lsls r4, r4, #0x18
	lsrs r4, r4, #0x18
	ldr r0, _020199CC @ =0x030008E0
	mov sl, r0
	ldr r1, _020199D0 @ =0x0201ADF8
	mov sb, r1
	adds r0, r4, #0
	adds r0, #0x40
	lsls r0, r0, #1
	add r0, sb
	movs r1, #0
	ldrsh r7, [r0, r1]
	mov r0, r8
	lsls r0, r0, #0x10
	asrs r0, r0, #0x10
	mov r8, r0
	adds r0, r7, #0
	mov r1, r8
	bl sub_020187A8
	lsls r6, r6, #5
	add r6, sl
	strh r0, [r6, #6]
	lsls r4, r4, #1
	add r4, sb
	movs r1, #0
	ldrsh r0, [r4, r1]
	mov r1, r8
	bl sub_020187A8
	strh r0, [r6, #0xe]
	ldrh r0, [r4]
	rsbs r0, r0, #0
	lsls r0, r0, #0x10
	asrs r0, r0, #0x10
	lsls r5, r5, #0x10
	asrs r5, r5, #0x10
	adds r1, r5, #0
	bl sub_020187A8
	strh r0, [r6, #0x16]
	adds r0, r7, #0
	adds r1, r5, #0
	bl sub_020187A8
	strh r0, [r6, #0x1e]
	pop {r3, r4, r5}
	mov r8, r3
	mov sb, r4
	mov sl, r5
	pop {r4, r5, r6, r7}
	pop {r0}
	bx r0
	.align 2, 0
_020199CC: .4byte 0x030008E0
_020199D0: .4byte 0x0201ADF8

	thumb_func_start sub_020199D4
sub_020199D4: @ 0x020199D4
	push {r4, lr}
	sub sp, #0x18
	mov r1, sp
	ldr r0, _020199EC @ =0x0201B108
	ldm r0!, {r2, r3, r4}
	stm r1!, {r2, r3, r4}
	ldm r0!, {r2, r3, r4}
	stm r1!, {r2, r3, r4}
	add sp, #0x18
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_020199EC: .4byte 0x0201B108

	thumb_func_start sub_020199F0
sub_020199F0: @ 0x020199F0
	push {r4, lr}
	mov ip, r0
	movs r4, #0x40
	str r4, [r0, #0x28]
	mov r1, ip
	adds r1, #0x40
	movs r3, #0
	movs r2, #0
	movs r0, #0x50
	strh r0, [r1]
	mov r0, ip
	strh r2, [r0, #0x3e]
	movs r0, #8
	rsbs r0, r0, #0
	mov r1, ip
	str r0, [r1, #0x20]
	mov r0, ip
	adds r0, #0x58
	strb r3, [r0]
	str r2, [r1, #0x1c]
	str r4, [r1, #0x18]
	subs r0, #2
	strb r3, [r0]
	movs r0, #0x80
	lsls r0, r0, #1
	strh r0, [r1, #0x3c]
	strh r0, [r1, #0x3a]
	ldr r1, _02019A38 @ =sub_020199D4
	mov r0, ip
	str r1, [r0, #0x10]
	bl sub_02019A74
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_02019A38: .4byte sub_020199D4

	thumb_func_start sub_02019A3C
sub_02019A3C: @ 0x02019A3C
	bx lr
	.align 2, 0

	thumb_func_start sub_02019A40
sub_02019A40: @ 0x02019A40
	push {lr}
	ldr r1, [r0, #0x10]
	cmp r1, #0
	beq _02019A4C
	bl sub_02019A74
_02019A4C:
	pop {r0}
	bx r0

	thumb_func_start sub_02019A50
sub_02019A50: @ 0x02019A50
	push {lr}
	ldrh r2, [r0, #0x3a]
	ldrh r1, [r0, #0x3c]
	adds r0, r2, #0
	movs r2, #0
	movs r3, #0
	bl sub_0201994C
	pop {r0}
	bx r0

	.endif

	thumb_func_start sub_02019A64
sub_02019A64: @ 0x02019A64
	svc #0xc
	bx lr

	thumb_func_start sub_02019A68
sub_02019A68: @ 0x02019A68
	svc #0xb
	bx lr

	thumb_func_start sub_02019A6C
sub_02019A6C: @ 0x02019A6C
	svc #1
	bx lr

	thumb_func_start sub_02019A70
sub_02019A70: @ 0x02019A70
	bx r0
	nop

	thumb_func_start sub_02019A74
sub_02019A74: @ 0x02019A74
	bx r1
	nop

	thumb_func_start sub_02019A78
sub_02019A78: @ 0x02019A78
	bx r2
	nop

	thumb_func_start sub_02019A7C
sub_02019A7C: @ 0x02019A7C
	bx r3
	nop

	thumb_func_start sub_02019A80
sub_02019A80: @ 0x02019A80
	bx r4
	nop

	thumb_func_start sub_02019A84
sub_02019A84: @ 0x02019A84
	bx r5
	nop

	thumb_func_start sub_02019A88
sub_02019A88: @ 0x02019A88
	bx r6
	nop

	thumb_func_start sub_02019A8C
sub_02019A8C: @ 0x02019A8C
	bx r7
	nop

	thumb_func_start sub_02019A90
sub_02019A90: @ 0x02019A90
	bx r8
	nop

	thumb_func_start sub_02019A94
sub_02019A94: @ 0x02019A94
	bx sb
	nop

	thumb_func_start sub_02019A98
sub_02019A98: @ 0x02019A98
	bx sl
	nop

	thumb_func_start sub_02019A9C
sub_02019A9C: @ 0x02019A9C
	bx fp
	nop

	thumb_func_start sub_02019AA0
sub_02019AA0: @ 0x02019AA0
	bx ip
	nop

	thumb_func_start sub_02019AA4
sub_02019AA4: @ 0x02019AA4
	bx sp
	nop

	thumb_func_start sub_02019AA8
sub_02019AA8: @ 0x02019AA8
	bx lr
	nop

	thumb_func_start sub_02019AAC
sub_02019AAC: @ 0x02019AAC
	cmp r1, #0
	beq _02019B34
	push {r4}
	adds r4, r0, #0
	eors r4, r1
	mov ip, r4
	movs r3, #1
	movs r2, #0
	cmp r1, #0
	bpl _02019AC2
	rsbs r1, r1, #0
_02019AC2:
	cmp r0, #0
	bpl _02019AC8
	rsbs r0, r0, #0
_02019AC8:
	cmp r0, r1
	blo _02019B26
	movs r4, #1
	lsls r4, r4, #0x1c
_02019AD0:
	cmp r1, r4
	bhs _02019ADE
	cmp r1, r0
	bhs _02019ADE
	lsls r1, r1, #4
	lsls r3, r3, #4
	b _02019AD0
_02019ADE:
	lsls r4, r4, #3
_02019AE0:
	cmp r1, r4
	bhs _02019AEE
	cmp r1, r0
	bhs _02019AEE
	lsls r1, r1, #1
	lsls r3, r3, #1
	b _02019AE0
_02019AEE:
	cmp r0, r1
	blo _02019AF6
	subs r0, r0, r1
	orrs r2, r3
_02019AF6:
	lsrs r4, r1, #1
	cmp r0, r4
	blo _02019B02
	subs r0, r0, r4
	lsrs r4, r3, #1
	orrs r2, r4
_02019B02:
	lsrs r4, r1, #2
	cmp r0, r4
	blo _02019B0E
	subs r0, r0, r4
	lsrs r4, r3, #2
	orrs r2, r4
_02019B0E:
	lsrs r4, r1, #3
	cmp r0, r4
	blo _02019B1A
	subs r0, r0, r4
	lsrs r4, r3, #3
	orrs r2, r4
_02019B1A:
	cmp r0, #0
	beq _02019B26
	lsrs r3, r3, #4
	beq _02019B26
	lsrs r1, r1, #4
	b _02019AEE
_02019B26:
	adds r0, r2, #0
	mov r4, ip
	cmp r4, #0
	bpl _02019B30
	rsbs r0, r0, #0
_02019B30:
	pop {r4}
	mov pc, lr
_02019B34:
	push {lr}
	bl sub_02019B40
	movs r0, #0
	pop {pc}
	.align 2, 0

	thumb_func_start sub_02019B40
sub_02019B40: @ 0x02019B40
	mov pc, lr
	.align 2, 0

	thumb_func_start sub_02019B44
sub_02019B44: @ 0x02019B44
	push {r4, r5, lr}
	adds r5, r0, #0
	adds r4, r1, #0
	adds r3, r5, #0
	cmp r2, #3
	bls _02019B8A
	movs r0, #3
	ands r0, r5
	cmp r0, #0
	bne _02019B8A
	adds r1, r5, #0
	movs r0, #0xff
	ands r4, r0
	lsls r3, r4, #8
	orrs r3, r4
	lsls r0, r3, #0x10
	orrs r3, r0
	cmp r2, #0xf
	bls _02019B7E
_02019B6A:
	stm r1!, {r3}
	stm r1!, {r3}
	stm r1!, {r3}
	stm r1!, {r3}
	subs r2, #0x10
	cmp r2, #0xf
	bhi _02019B6A
	b _02019B7E
_02019B7A:
	stm r1!, {r3}
	subs r2, #4
_02019B7E:
	cmp r2, #3
	bhi _02019B7A
	adds r3, r1, #0
	b _02019B8A
_02019B86:
	strb r4, [r3]
	adds r3, #1
_02019B8A:
	adds r0, r2, #0
	subs r2, #1
	cmp r0, #0
	bne _02019B86
	adds r0, r5, #0
	pop {r4, r5, pc}

	@ Public names used by the reconstructed C sources.
	.global CpuFastSet
	.thumb_set CpuFastSet, sub_02019A64
	.global CpuSet
	.thumb_set CpuSet, sub_02019A68
	.global RegisterRamReset
	.thumb_set RegisterRamReset, sub_02019A6C
	.global _call_via_r0
	.thumb_set _call_via_r0, sub_02019A70
	.global _call_via_r1
	.thumb_set _call_via_r1, sub_02019A74
	.global _call_via_r2
	.thumb_set _call_via_r2, sub_02019A78
	.global _call_via_r3
	.thumb_set _call_via_r3, sub_02019A7C
	.global _call_via_r4
	.thumb_set _call_via_r4, sub_02019A80
	.global _call_via_r5
	.thumb_set _call_via_r5, sub_02019A84
	.global _call_via_r6
	.thumb_set _call_via_r6, sub_02019A88
	.global _call_via_r7
	.thumb_set _call_via_r7, sub_02019A8C
	.global _call_via_r8
	.thumb_set _call_via_r8, sub_02019A90
	.global _call_via_r9
	.thumb_set _call_via_r9, sub_02019A94
	.global _call_via_sl
	.thumb_set _call_via_sl, sub_02019A98
	.global _call_via_fp
	.thumb_set _call_via_fp, sub_02019A9C
	.global _call_via_ip
	.thumb_set _call_via_ip, sub_02019AA0
	.global _call_via_sp
	.thumb_set _call_via_sp, sub_02019AA4
	.global _call_via_lr
	.thumb_set _call_via_lr, sub_02019AA8
	.global __divsi3
	.thumb_set __divsi3, sub_02019AAC
	.global __div0
	.thumb_set __div0, sub_02019B40
	.global memset
	.thumb_set memset, sub_02019B44

.align 2, 0
