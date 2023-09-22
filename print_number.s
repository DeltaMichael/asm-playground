.globl print_num
.type print_num, @function
.section .data
numcodes:
	.ascii "0123456789ABCDEF"
.section .text
print_num:
	# copy numcodes address to register
	movq $numcodes, %rdx
	# init count
	movq $-8, %rcx
	# create buffer
	enter $128, $0
	# number to print is in %rdi
loop:
	# get the least significant tetrade
	mov %rdi, %rbx
	andq $0xf, %rbx
	
	# get the char value from the ascii codes using the tetrade as offset
	lea (%rdx, %rbx, 1), %rbx
	movq (%rbx), %rbx
	# push the value on the stack
	movb %bl, (%rbp, %rcx, 1)
	# decrement the counter
	subq $8, %rcx
	# shif the number right for the next mask
	shr $4, %rdi
	jnz loop
print:
	# syscall number is 1
	movq $1, %rax
	# load file descriptor into rdi (stdout)
	movq $1, %rdi
	# load the address of the stack pointer offset by the counter
	lea (%rbp,%rcx,1), %rsi
	# load the counter into rdx and negate to get the length
	movq %rcx, %rdx
	neg %rdx
	
	syscall
complete:
	movq $0, %rax
	leave
	ret
