.globl _start
.section .text
_start:
	movq $69, %rax
	movq $69, %rdx
	cmp %rax, %rdx
	pushfq
	popq %rdi
	and $0b1000000, %rdi
	shr $6, %rdi
	movq $60, %rax
	syscall
