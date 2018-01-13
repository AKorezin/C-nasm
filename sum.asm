global sum
section .text

; rdi rsi rdx

sum:
	pxor xmm0, xmm0
	mov r8, rsi
	mov r9, rdx
	mov r10, rdi
	shr r10, 2
	jz single

	shl r10, 4
loop2:
	movups xmm1, [r8+r10-16]
	movups xmm2, [r9+r10-16]
	shufps xmm1, xmm1, 00001101b
	shufps xmm2, xmm2, 00001101b
	mulps xmm1, xmm2
	addps xmm0, xmm1
	sub r10, 16
	jnz loop2
	haddps xmm0, xmm0

single:
	mov r10, rdi
	and r10, 11b
	jz done
	mov r10, rdi
	and r10, 0xFFFFFFFFFFFFFFFC
	shl r10, 2
	movss xmm1, [r8+r10+4]
	mulss xmm1, [r9+r10+4]
	addss xmm0, xmm1
done:
	ret
