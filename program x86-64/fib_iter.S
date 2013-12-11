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
	movq $2, %rcx		# Init iterator i = 2
	movq $1, %r10		# min_one = 1
	movq $0, %r11		# min_two = 0
	jmp while
if_0:	movq $0, %rax		# we're done, put 0 in rax
	jmp endif
if_1:	movq $1, %rax		# we're done, put 1 in rax
	jmp endif
while:	cmpq %rdi, %rcx		# while( i < n ) {
	je endwhile		
	incq %rcx		# i++
	addq %r10, %r11		# min_two = min_one + min_two
	movq %r11, %r8		# r = min_two
	movq %r10, %r11		# minus_two = minus_one
	movq %r8, %r10		# minus_one = r
	jmp while		# }
endwhile:
	addq %r10, %r11		# min_one + min_two
	movq %r11, %rax		# we're done, put r in rax
endif:	leave
	ret
