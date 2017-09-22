global add_asm
section .text

add_asm:
	xor eax,eax
	test edi, edi
	jz done
	lea r9, [edi*4]
	xor r11, r11
	prefetchnta [rdx+r11+128]
	prefetchnta [rsi+r11+128]
loop:
	mov r10d, [rdx+r11]
	imul r10d, [rsi+r11]
	add r11, 4
	add eax, r10d
	cmp r11, r9
	jne loop
done:
	ret
