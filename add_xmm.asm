global add_xmm_asm
global add_xmm_new_asm
section .text

add_xmm_asm:
	xor eax, eax
	test edi, edi
	jz done
	pxor xmm2, xmm2
	lea r9, [edi*4]
	xor r11, r11
	cmp edi, 4
	jl endloop
	sub r9, 16
mainloop:
	movdqa xmm0, [rsi+r11]
	movdqa xmm1, [rdx+r11]
	pmulld xmm0, xmm1
	add r11, 16
	paddd xmm2, xmm0
	cmp r11, r9
	jle mainloop
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
	jl endloop
done:
	ret


add_xmm_new_asm:
	xor eax, eax
	pxor xmm4, xmm4
	xor rcx, rcx
	push rbx
decide1:
	mov ebx, edi
	shr ebx, 4
	cmp ebx, 0
	jg preloop16
decide2:
	mov ebx, edi
	and ebx, 12
	cmp ebx, 12
	je preloop12
	cmp ebx, 8
	je preloop8
	cmp ebx, 4
	je preloop4
decide3:		
	and edi, 3
	cmp edi, 3
	je preloop3
	cmp edi, 2
	je preloop2
	cmp edi, 1
	je preloop1

preloop1:
loop1:
	mov ebx, [rsi+rcx]
	imul ebx, [rdx+rcx]
	add eax, ebx
	jmp done1
preloop2:
loop2:
	mov ebx, [rsi+rcx]
	imul ebx, [rdx+rcx]
	add eax, ebx
	mov ebx, [rsi+rcx+4]
	imul ebx, [rdx+rcx+4]
	add eax, ebx
	jmp done1
preloop3:
loop3:
	mov ebx, [rsi+rcx]
	imul ebx, [rdx+rcx]
	add eax, ebx
	mov ebx, [rsi+rcx+4]
	imul ebx, [rdx+rcx+4]
	add eax, ebx
	mov ebx, [rsi+rcx+8]
	imul ebx, [rdx+rcx+8]
	add eax, ebx
	jmp done1
preloop4:
loop4:
	movdqa xmm0, [rsi+rcx]
	movdqa xmm1, [rdx+rcx]
	pmulld xmm0, xmm1
	add rcx, 16
	haddps xmm0, xmm0
	haddps xmm0, xmm0
	movd ebx, xmm0
	add eax, ebx
	jmp decide3
preloop8:
loop8:
	movdqa xmm0, [rsi+rcx]
	movdqa xmm1, [rdx+rcx]
	movdqa xmm2, [rsi+rcx+16]
	movdqa xmm3, [rdx+rcx+16]
	pmulld xmm0, xmm1
	pmulld xmm2, xmm3
	paddd xmm0, xmm2
	add rcx, 32
	haddps xmm0, xmm0
	haddps xmm0, xmm0
	movd ebx, xmm0
	add eax, ebx
	jmp decide3
preloop12:
loop12:
	movdqa xmm0, [rsi+rcx]
	movdqa xmm1, [rdx+rcx]
	movdqa xmm2, [rsi+rcx+16]
	movdqa xmm3, [rdx+rcx+16]
	movdqa xmm4, [rsi+rcx+32]
	movdqa xmm5, [rdx+rcx+32]
	pmulld xmm0, xmm1
	pmulld xmm2, xmm3
	pmulld xmm4, xmm5
	paddd xmm0, xmm2
	paddd xmm0, xmm4
	add rcx, 48
	haddps xmm0, xmm0
	haddps xmm0, xmm0
	movd ebx, xmm0
	add eax, ebx
	jmp decide3
preloop16:
	shl ebx, 6
loop16:
	movdqa xmm0, [rsi+rcx]
	movdqa xmm1, [rdx+rcx]
	movdqa xmm2, [rsi+rcx+16]
	movdqa xmm3, [rdx+rcx+16]
	pmulld xmm0, xmm1
	pmulld xmm2, xmm3
	paddd xmm4, xmm0
	paddd xmm4, xmm2
	movdqa xmm0, [rsi+rcx+32]
	movdqa xmm1, [rdx+rcx+32]
	movdqa xmm2, [rsi+rcx+48]
	movdqa xmm3, [rdx+rcx+48]
	pmulld xmm0, xmm1
	pmulld xmm2, xmm3
	paddd xmm4, xmm0
	paddd xmm4, xmm2
	add ecx, 64
	cmp ecx, ebx
	jl loop16
	haddps xmm4, xmm4
	haddps xmm4, xmm4
	movd ebx, xmm4
	add eax, ebx
	jmp decide2
done1:
	pop rbx
	ret
