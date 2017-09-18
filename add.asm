global add_asm
section .text

add_asm:
	mov r10, rdi
	mov rax,0
check:
	test r10, r10
	jz done
loop:
	mov r8, [rcx]
	mov r9, [rsi]
	imul r8, r9
	add rax, r8
	add rcx,4
	add rsi,4
	dec r10
	jmp check
done:
	ret
