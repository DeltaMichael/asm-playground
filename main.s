.globl _start
.section .text
_start:
	movq $0xFFFFFFFFFFFFFFFF, %rdi
	call print_dec
	movq $0, %rdi
	movq $60, %rax
	syscall
