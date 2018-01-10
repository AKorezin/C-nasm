global sum
section .text

; rdi rsi rdx r10 r8 r9

sum:
	pxor xmm4, xmm4
	mov r8, rdx
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
	mulsd xmm1, [r8+rax]
	movsd xmm2, [r10+rax]
	addsd xmm1, xmm2
	addsd xmm0, xmm1
	ret
preloop2:
	mov edx, 24
	mul edx
loop2:
	movupd xmm1, [rsi+rax-24]
	movupd xmm2, [r8+rax-24]
	movupd xmm3, [r10+rax-24]
	mulpd xmm1, xmm2
	addpd xmm4, xmm3
	addpd xmm4, xmm1
	sub eax, 24
	jnz loop2
	haddpd xmm4, xmm4
	addsd xmm0, xmm4
	jmp decide
done:
	ret
