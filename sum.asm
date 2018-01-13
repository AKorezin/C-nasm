global sum
section .text

; rdi rsi rdx

sum:
	pxor xmm0, xmm0
	mov r8, rsi
	mov r9, rdx
	mov r10, rdi
	mov rcx, r10
	shr r10, 1
	jz single

	shl r10, 1
	sub rcx, r10
	shl r10, 3
	shl rcx, 3
loop2:
	movupd xmm1, [r8+r10-16]
	movupd xmm2, [r9+rcx]
	shufpd xmm2, xmm2, 01b
	mulpd xmm1, xmm2
	addpd xmm0, xmm1
	add rcx, 16
	sub r10, 16
	jnz loop2
	haddpd xmm0, xmm0

single:
	mov r10, rdi
	and r10, 1b
	jz done
	mov r10, rdi
	shl r10, 3
	movsd xmm1, [r8+r10]
	mulsd xmm1, [r9]
	addsd xmm0, xmm1
done:
	ret
