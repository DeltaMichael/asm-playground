.globl _start
.section .data
numcodes:
	.ascii "0123456789ABCDEF"
.section .text
_start:
	movq $0x0ABCDEFABCDEFABC, %r10
	movq $0xF000000000000000, %r13
	movq $64, %r8
print_loop:
	# decrement shift counter
	subq $4, %r8

	# AND mask with number
	movq %r13, %rbx
	andq %r10, %rbx
	# syscall for print is 1
	movq $1, %rax
	# file descriptor
	movq $1, %rdi
	# pointer to data
	movq $numcodes, %r12
	
	# move the shift counter into rcx
	# we can only shift by register using cl
	movq %r8, %rcx
	shr %cl, %rbx
	# lea (base, offset, multiplier), destination
	# rsi = r12 + 1 * rbx
	lea (%r12, %rbx, 1), %rsi

	# data length
	movq $1, %rdx
	syscall
	shr $0x4, %r13
	jnz print_loop
exit:
	movq $0x3c, %rax
	movq $0, %rdi
	syscall
