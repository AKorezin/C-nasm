global add_xmm_asm
section .text

add_xmm_asm:
	xor eax, eax
	test edi, edi
	jz done
	pxor xmm2, xmm2
	lea r9, [edi*4-16]
	xor r11, r11
loop:
	movdqa xmm0, [rsi+r11]
	movdqa xmm1, [rdx+r11]
	pmulld xmm0, xmm1
	add r11, 16
	paddd xmm2, xmm0
	cmp r11, r9
	jle loop
	haddps xmm2, xmm2
	add r9, 16
	haddps xmm2, xmm2
	movd eax, xmm2
	cmp r11, r9
	jge done
endloop:
	mov r10d, [rsi+r11]
	imul r10d, [rdx+r11]
	add r11, 4
	add eax, r10d
	cmp r11, r9
	jne endloop
done:
	ret
