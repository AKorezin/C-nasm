global add_asm
section .text

add_asm:
	mov rax,0
check:
	test edi, edi
	jz done
	mov r10, [rcx]
	imul r10, [rsi]
	add rax, r10
	add rcx,4
	add rsi,4
	dec edi
	jmp check
done:
	ret
