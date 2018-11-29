#ori kopel 205533151
#print convention: RDI, RSI, RDX, RCX, R8, R9
.section .rodata
strlenP: 				.string 		"first pstring length: %d, second pstring length: %d\n"
replaceCharP :	.string 		"old char: %c, new char: %c, first string: %s, second string: %s\n"
scanC: 				.string 		"\n%c %c"
scanNums :		.string 		"\n%d\n%d"
errormsg: 			.string 		"invalid option!\n"
print:					.string		"f:%d, s:%d\n"
print1:					.string		"f:%d\n"
.L10:
    .quad .L0 #option 50
    .quad .L1 #option 51
    .quad .L2 #option 52
    .quad .L3 #option 53
    .quad .L4 #option 54


.text
.global run_func
run_func:
	pushq	%rbp		#save the old frame pointer
    mov	%rsp,	%rbp	#create the new frame pointer
###############start of code


	leaq -50(%rdi),%rdi 			#the operation num comes in RDI
	cmpq $4, %rdi   				#compare xi:4 becouse our range is 51/52/53/54
    ja .L5  									#big than 4 so go to default
   
	jmp *.L10(,%rdi,8) 				#goto write case
	ret
	
	
.L0: #option 50

	xorq %rax, %rax 		#inition RAX
	movq (%rsi), %rax	#move the first pstring to RAX
	call pstrlen					#check the len
	movq %rax, %r12 	#save the answer from RAX for later.
	
	xorq %rax, %rax 		#inition RAX
	movq (%rdx), %rax	#move the second pstring to RAX
	call pstrlen					#check the len

	movq %r12,%rdx		#restore the first len in order to print
	xorq %r12, %r12		#inition the R12 after using.
	mov $strlenP, %rdi 	#format to RDI
	xorq %rax, %rax			#init RAX
	call printf						#print
	
jmp .L5			#done

.L1: 						#option 51
	movq %rsi, %r12					#backUp pstr1
	movq %rdx, %r13					#backUp pstr2
	xorq %rax, %rax						#init RAX
	xorq %rdi, %rdi						#init RDI
	movq $scanC, %rdi				#scanf format
	subq $2, %rsp						#allocate place to the chars
	leaq 1(%rsp), %rsi					#RSI point to place of the first scanf
	movq %rsp, %rdx					#RDX point to place of the second scanf
	call scanf
	movq 1(%rsp), %rsi
	movq (%rsp), %rdx
	xorq %rax, %rax						#init RAX
	movq %r12, %rdi					#move pstr1 to RDI (to the function)
	call replaceChar
	movq %rax, %r12					#move the answer to print place
	xorq %rdi, %rdi
	movq %r13, %rdi					#move pstr2 to RDI (to the function)
	xorq %rax, %rax
	call replaceChar
	movq %rax, %r13					#move the answer to print place
	mov $replaceCharP, %rdi 	#format to RDI
	leaq 1(%r12), %rcx				#mov the pstring1 adrees (-1 to delete the len) to print place
	leaq 1(%r13), %r8					# ---"--- (pstring2)
	xorq %rax, %rax						#init RAX
	call printf									#print
	xorq %rax, %rax						#init RAX

	addq $2, %rsp						#restore the original RSP

jmp .L5

	
.L2: #option 52

	movq %rsi, %r12					#backUp pstr1
	movq %rdx, %r13					#backUp pstr2
	xorq %rax, %rax						#init RAX
	xorq %rdi, %rdi						#init RDI
	subq $16, %rsp						#allocate place to the nums(4/8 bytes per num)
	movq $scanNums, %rdi		#scanf format
	leaq 8(%rsp), %rsi				#RSI point to place of the first scanf
	movq %rsp, %rdx					#RDX point to place of the second scanf
	call scanf
	movq (%rsp), %rdx				#take the value of j to RDX
	movq 8(%rsp), %rsi				#take the value of i to RSI
	
	#movq $print1, %rdi
	#xorq %rax, %rax
	#call printf
	#jmp .endof52
	
	#start of validation#
#	cmpl $0, %esi						#check if i<=0
#	jl .error									#jump to error
#	cmpl $0, %edx						#check if j<0
#	jl .error									#jump to error
#	cmpl %edx, %esi					#check if j<i , edx<esi
#	jg .error									#jump to error
	
	xorq %rax, %rax 					#inition RAX
	movq (%r12), %rax				#move the first pstring to RAX
	call pstrlen								#check the len
	
	#xorq %rsi, %rsi
	#movb %al, %sil
	#movq $print1, %rdi
	#xorq %rax, %rax
	#call printf

	#movq %rax, %r14 	#save the answer from RAX for later.
	#cmpl %r14d, %edx	#check if pstrlen1 < j
	cmpb %al, %dl	#check if pstrlen1 < j
	jg .error						#jump to error
	
#	xorq %rax, %rax 		#inition RAX
#	movq %r13, %rax		#move the second pstring to RAX
#	call pstrlen					#check the len
#	movq %rax, %r15 	#save the answer from RAX for later.
#	cmpq %r15, %rdx	#check if j>pstrlen2
#	jg .error
										#end of validation#
	
	#xorq %rax, %rax			#inition rax
	#call pstrijcpy
	
	jmp .endof52
.error:											#Error in validation
	movq $errormsg, %rdi
	xorq %rax, %rax
	call printf

.endof52:
	addq $8, %rsp						#restore the original RSP
jmp .L5

.L3: #option 53

call swapCase

jmp .L5

.L4: #option 54
call pstrijcmp

jmp .L5

.L5: 					#done
	

	
	
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    pop	%rbp		#restore old frame pointer (the caller function frame)
    ret	
