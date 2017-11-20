global add_d_asm
section .text

add_d_asm:
	pxor xmm0, xmm0
	mov ecx, edi
	shr ecx, 2
	jnz preloop4
decide:
	mov ecx, edi
	and ecx, 3
	jnz preloop1
	ret
preloop4:
	shl ecx, 5
loop4:
	movapd xmm1, [rsi+rcx-32]
	movapd xmm2, [rdx+rcx-32]
	movapd xmm3, [rsi+rcx-16]
	movapd xmm4, [rdx+rcx-16]
	mulpd xmm1, xmm2
	mulpd xmm3, xmm4
	addpd xmm0, xmm1
	addpd xmm0, xmm3
	sub ecx, 32
	jnz loop4
	haddpd xmm0, xmm0
	jmp decide
preloop1:
	shl edi, 3
	mov ecx, edi
	and cl, 0xE0
loop1:
	movsd xmm1, [rsi+rcx]
	mulsd xmm1, [rdx+rcx]
	add ecx, 8
	addsd xmm0, xmm1
	cmp ecx, edi
	jl loop1
done:
	ret
