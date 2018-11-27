.section .rodata

c: .string "%c"
cc: .string "%c\n"
.text
.global main
main:

 movq %rsp, %rbp #for correct debugging
    	# get char and than print him	
	# get char and than print him	
	
	leaq	-9(%rbp), %rax	# allcate memmory to the enter comes after the last input
	movq	%rax, %rsi		# this will get the dummy - the enter comes after the last input
	movl	$cc, %edi		# c = "%c"
	movl	$0, %eax
	call	scanf
	
	leaq	-9(%rbp), %rax	# I will put the char that comes as input in the same place that the dummy was
	movq	%rax, %rsi		# the second parameter to scanf 
	movl	$cc, %edi		# c = "%c"
	movl	$0, %eax
	call	scanf
	
	movzbl	-9(%rbp), %eax	# get the char from the stack
	movsbl	%al, %eax		# take the first byte
	movb	%al, %sil		# put the char in %sil - second parameter to printf
	
	movl	$c, %edi		# c = "%c\n"
	movl	$0, %eax
	call	printf

    # write your code here
    xorq  %rax, %rax
    ret
    