global add_xmm_asm
section .text

;
;	required avx
;

;
;	keep in mind
;	save
;	x86: EBP, EBX, EDI, ESI
;	x86_64: RBP, RBX, R12, R13, R14, R15
;	microsoft x86_64: RBP, RBX, RSI, RDI, R12, R13, R14, R15, XMM6..XMM15
;	

add_xmm_asm:
	xor eax, eax
	mov ecx, edi
	shr ecx, 3
	jnz preloop8
decide:
	mov ecx, edi
	and ecx, 7
	jnz preloop1 	
	ret
preloop8:
	pxor xmm4, xmm4
	shl ecx, 5
loop8:
	vmovdqa xmm0, [rsi+rcx-32]
	vmovdqa xmm1, [rdx+rcx-32]
	vmovdqa xmm2, [rsi+rcx-16]
	vmovdqa xmm3, [rdx+rcx-16]
	vpmulld xmm0, xmm1
	vpmulld xmm2, xmm3
	vpaddd xmm4, xmm0
	vpaddd xmm4, xmm2
	sub ecx, 32
	jnz loop8
	vphaddd xmm4, xmm4
	vphaddd xmm4, xmm4
	movd eax, xmm4
	jmp decide
preloop1:
	shl edi, 2
	mov ecx, edi
	and cl, 0xE0
loop1:
	mov r8d, [rsi+rcx]
	imul r8d, [rdx+rcx]
	add ecx, 4
	add eax, r8d
	cmp ecx, edi
	jl loop1
done:
	ret
