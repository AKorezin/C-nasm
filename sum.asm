global sum
section .text

sum:
	mov r9, rdx
	mov r10, rcx
	pxor xmm0, xmm0
	mov edx, 0
	mov eax, edi
	mov ecx, 3
	div ecx
	cmp edx, 2
	jne skip
	inc eax
skip:
	cmp eax, 0
	jne preloop2
decide:
	mov edx, 0
	mov eax, edi
	mov ecx, 3
	div ecx
	cmp edx, 1
	jne done
	mov edx, 24
	mul edx
	movsd xmm1, [rsi+rax]
	mulsd xmm1, [r9+rax]
	mulsd xmm1, [r10+rax]
	addsd xmm0, xmm1
	jmp done
preloop2:
	mov edx, 24
	mul edx
loop2:
	movupd xmm1, [rsi+rax-24]
	movupd xmm2, [r9+rax-24]
	movupd xmm3, [r10+rax-24]
	mulpd xmm1, xmm2
	mulpd xmm1, xmm3
	addpd xmm0, xmm1
	sub rax, 24
	jnz loop2
	haddpd xmm0, xmm0
	jmp decide
done:
	ret
