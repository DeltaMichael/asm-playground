.globl _start
.section .text
_start:
	movq $0xFAFA, %rdi
	call print_num
	movq $0, %rdi
	movq $60, %rax
	syscall
