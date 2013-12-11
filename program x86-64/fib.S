        .global main		  # main is a global symbol

        .section .data		  # the place for data
result: .asciz "fib(%qd) = %qd\n" # text to be printed
argc:	.long 0
argv:	.quad 0
a:	.quad 0

        .section .text		# beginning of actual code
main:	pushq %rbp		# save old rbp to stack
	movq %rsp, %rbp	        # set new value for rbp
	movl %edi, argc 	# save argc
	movq %rsi, argv 	# save argv
	movq argv, %rax 	# get argv back
	movq 8(%rax), %rdi	# first argument 8-byte aligned
	call atol		# call atol
	movq %rax, a 		# save a
	movq %rax, %rdi		# first argument
	call fib		# fib(a)
	movq %rax,%rdx		# third argument
	movq a,%rsi		# second argument
	movq $result,%rdi	# first argument
	xor %al,%al		# no vector args
	call printf		# printf("fib(%qd) = %qd\n",a,fac(a))
	xor %rax,%rax		# return code 0 for success
	leave			# clean up, restore rbp
        ret			# return / end program

fib:	push %rbp		# save old base pointer
	movq %rsp, %rbp		# establish new base pointer
	subq $16,%rsp		# make room for n
	cmpq $0,%rdi		# if (n == 0)
	je if_0 			
	cmpq $1,%rdi		# if (n == 1)
	je if_1
	jmp else
if_0:	movq $0, %rax		# we're done, put 0 in rax
	jmp endif
if_1:	movq $1, %rax		# we're done, put 1 in rax
	jmp endif
else:	decq %rdi		# rdi = n - 1
	movq %rdi,-8(%rbp)	# save n - 1
	call fib		# rax = fib(n - 1)
	movq -8(%rbp),%rdi	# rdi = n -1
	decq %rdi		# rdi = n - 2
	movq %rax,-8(%rbp)	# save fib(n - 1)
	call fib		# rax = fib(n - 2)
	addq -8(%rbp),%rax	# rax = fib(n - 1) + fib(n - 2)
endif:	leave
	ret
