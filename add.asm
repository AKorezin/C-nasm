global add_asm
section .text

add_asm:
	mov r10d, edi
	mov eax,0
check:
	test r10d, r10d
	jz done
loop:
	mov r8d, [rcx]
	mov r9d, [rsi]
	imul r8d, r9d
	add eax, r8d
	add rcx,4
	add rsi,4
	dec r10d
	jmp check
done:
	ret
