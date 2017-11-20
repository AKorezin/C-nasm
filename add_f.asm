global add_f_asm
section .text

add_f_asm:
	pxor xmm0, xmm0
	mov ecx, edi
	shr ecx, 3
	jnz preloop8
decide:
	mov ecx, edi
	and ecx, 7
	jnz preloop1
	ret
preloop8:
	shl ecx, 5
loop8:
	movaps xmm1, [rsi+rcx-32]
	movaps xmm2, [rdx+rcx-32]
	movaps xmm3, [rsi+rcx-16]
	movaps xmm4, [rdx+rcx-16]
	mulps xmm1, xmm2
	mulps xmm3, xmm4
	addps xmm0, xmm1
	addps xmm0, xmm3
	sub ecx, 32
	jnz loop8
	haddps xmm0, xmm0
	haddps xmm0, xmm0
	jmp decide
preloop1:
	shl edi, 2
	mov ecx, edi
	and cl, 0xE0
loop1:
	movss xmm1, [rsi+rcx]
	mulss xmm1, [rdx+rcx]
	add ecx, 4
	addss xmm0, xmm1
	cmp ecx, edi
	jl loop1
done:
	ret
