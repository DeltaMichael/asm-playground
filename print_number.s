.globl _start
.section .data
numcodes:
	.ascii "0123456789ABCDEF"
.section .text
_start:
	enter $192, $0
	# number
	mov $0x0ABCDEFABCDEFABC, %rax
	mov %rax, -64(%rbp)
	# mask
	movq $0xF000000000000000, %rax
	movq %rax, -128(%rbp)
	# offset
	movq $64, -192(%rbp)
print_loop:
	# decrement shift counter
	subq $4, -192(%rbp)

	# AND mask with number
	movq -128(%rbp), %rbx
	andq -64(%rbp), %rbx
	# syscall for print is 1
	movq $1, %rax
	# file descriptor
	movq $1, %rdi
	# pointer to data
	movq $numcodes, %r8
	
	# move the shift counter into rcx
	# we can only shift by register using cl
	movq -192(%rbp), %rcx
	shr %cl, %rbx
	# lea (base, offset, multiplier), destination
	# rsi = r8 + 1 * rbx
	lea (%r8, %rbx, 1), %rsi

	# data length
	movq $1, %rdx
	syscall
	
	# shift mask right
	movq -128(%rbp), %rax
	shr $0x4, %rax
	movq %rax, -128(%rbp)

	addq $0, %rax
	jnz print_loop
exit:
	leave
	movq $0x3c, %rax
	movq $0, %rdi
	syscall
