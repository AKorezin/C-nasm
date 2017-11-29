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
	shr ecx, 4
	jnz preloop16
decide:
	mov ecx, edi
	and ecx, 15
	jnz preloop1 	
	ret
preloop16:
	vpxor ymm4, ymm4
	shl ecx, 6
loop16:
	vmovdqa ymm0, [rsi+rcx-64]
	vmovdqa ymm1, [rdx+rcx-64]
	vmovdqa ymm2, [rsi+rcx-32]
	vmovdqa ymm3, [rdx+rcx-32]
	vpmulld ymm0, ymm1
	vpmulld ymm2, ymm3
	vpaddd ymm4, ymm0
	vpaddd ymm4, ymm2
	sub ecx, 64
	jnz loop16
	vphaddd ymm4, ymm4
	vphaddd ymm4, ymm4
	vextracti128 xmm0, ymm4, 1
	vpaddd xmm0, xmm4
	movd eax, xmm0
	jmp decide
preloop1:
	shl edi, 2
	mov ecx, edi
	and cl, 0xC0
loop1:
	mov r8d, [rsi+rcx]
	imul r8d, [rdx+rcx]
	add ecx, 4
	add eax, r8d
	cmp ecx, edi
	jl loop1
done:
	ret
