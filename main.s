.globl _start
.section .text
_start:
	movq $0xFFFFFFFFFFFFFFFF, %rdi
	call print_num
	movq $0xFFFFFFFFFFFFFFFF, %rdi
	call print_hex
	movq $0, %rdi
	movq $60, %rax
	syscall
