global rdtsc
section .text

rdtsc:
	rdtsc
	shl rdx, 32
	or rax, rdx
	ret
