#ori kopel 205533151
.section .rodata
input: 		.string		 "%d"
input2: 		.string		 "\n%s"
ftest:	.string "%s\n"
.text
.global main
main:
	pushq	%rbp				#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
	pushq 	%r12				#save colle saver
	pushq 	%r13				# "
	pushq 	%r14				# "
	pushq 	%r15				# "
############################################start of code
	#get len1 to R12 and pstr1, and after put them together in R13
	xorq 			%rdi, %rdi			#init RDI
	movq 		$input, %rdi			#set the print format
	subq 		$8, %rsp				#allocate place to the num(8 bytes)
	movq 		%rsp, %rsi			#RSI point to place of the scanf
	xorq 			%rax, %rax			#init rax
	call scanf								#scan len1
	movzbq 	(%rsp), %r12		#save pstr1len in R12
	addq 		$7, %rsp				#take it 7up in order to selete the '\0'
	subq 		%r12, %rsp			#place to get pstr1
	movq 		$input2, %rdi			#set the print format
	xorq 			%rsi, %rsi				#init rax
	leaq 			(%rsp), %rsi			#RSI point to place of the scanf
	xorq 			%rax, %rax			#inition rax
	call scanf								#scan pstr1
	decq			%rsp					#doing place to the len1 to be together with pstr
	movb 		%r12b,(%rsp)      # move the len to the pstring
	movq		%rsp, %r13			#save len1+pstr1 in R13
	xorq 			%r12, %r12

	xorq			%rdi, %rdi
	subq 		$8, %rsp				#allocate place to the num(8 bytes)
	movq 		$input, %rdi			#set the print format
	movq 		%rsp, %rsi			#Rsi point to place of the scanf
	xorq 			%rax, %rax			#init rax
	call scanf								#scan len2
	movzbq 	(%rsp), %rsi			#save pstr2len in R12
	movq 		%rsi, %r12
	addq 		$7, %rsp				#take it 7up in order to selete the '\0'
	subq 		%r12, %rsp			#place to get pstr2
	movq 		$input2, %rdi			#set the print format
	xorq 			%rsi, %rsi
	leaq			(%rsp), %rsi			#RSI point to place of the scanf
	xorq 			%rax, %rax			#init rax
	call scanf
	decq 		%rsp
	movb 		%r12b,(%rsp)
	movq 		%rsp, %r14
	xorq 			%r12, %r12

	#scan operation num
	xorq 			%rdi, %rdi			#init RDI
	xorq 			%rax, %rax			#init rax
	movq 		$input, %rdi			#set the print format
	subq 		$4, %rsp				#allocate place to the num(8 bytes)
	movq		%rsp, %rsi			#RSI point to place of the scanf
	call scanf								#scan op num
	movzbq 	(%rsp), %rdi		#save op num in RDI (first parameter to run_func)
	
	movq 	%r13, %rsi			#len1+pstr1
	movq 	%r14, %rdx			#len2+pstr2
	xorq 		%rax, %rax			#init rax
	call run_func
	xorq 		%rax, %rax			#init rax
	#############################################################################
    popq		%r12					# restoring the callee registers
    popq		%r13					# -"-
    popq 	%r14					# -"-
    popq 	%r15					# -"-       
	movq 	$0, %rdi				#return value is zero
    movq 	%rbp, %rsp			#restore the old stack pointer - release all used memory.
    pop 		%rbp					#restore old frame pointer (the caller function frame)
    ret
####################################################################################
