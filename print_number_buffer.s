.globl _start
.section .data
numcodes:
	.ascii "0123456789ABCDEF"
.section .text
_start:
	# create buffer
	enter $128, $0
	# store in buffer
	movb $0x48, -8(%rbp)
	movb $0x47, -16(%rbp)
	movb $0x46, -24(%rbp)
	movb $0x45, -32(%rbp)
	movb $0x44, -40(%rbp)
	movb $0x43, -48(%rbp)
	movb $0x42, -56(%rbp)
	movb $0x41, -64(%rbp)
	
	# syscall number is 1
	movq $1, %rax
	# print buffer
	movq $1, %rdi
	movq $-64, %rcx
	lea (%rbp,%rcx,1), %rsi
	movq $64, %rdx
	syscall
	# exit
	leave
	movq $0x3c, %rax
	movq $0, %rdi
	syscall

