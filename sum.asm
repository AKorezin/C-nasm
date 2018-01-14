global sum
section .text

sum:
	pxor xmm0, xmm0
	mov r8, rdx
	mov edx, 0
	mov eax, edi
	mov r9d, 5
	div r9d
	cmp edx, 4
	jne skip
	inc eax
skip:
	cmp eax, 0
	je decide

	mov edx, 20
	mul edx
loop4:
	movups xmm1, [rsi+rax-20]
	movups xmm2, [r8+rax-20]
	movups xmm3, [rcx+rax-20]
	mulps xmm1, xmm2
	addps xmm0, xmm3
	addps xmm0, xmm1
	sub eax, 20
	jnz loop4

	haddps xmm0, xmm0
	haddps xmm0, xmm0

decide:
	mov edx, 0
	mov eax, edi
	mov r9d, 5
	div r9d
	cmp edx, 0
	je done

	mov edx, 20
	mul edx
	shl edi, 2
loop1:
	movss xmm1, [rsi+rax]
	mulss xmm1, [r8+rax]
	movss xmm2, [rcx+rax]
	addss xmm0, xmm1
	addss xmm0, xmm2
	add eax, 4
	cmp eax, edi
	jne loop1
done:
	ret
