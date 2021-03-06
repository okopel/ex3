#ori kopel 205533151
#print convention: RDI, RSI, RDX, RCX, R8, R9
.section .rodata
strlenP: 				.string 			"first pstring length: %d, second pstring length: %d\n"
replaceCharP :		.string 			"old char: %c, new char: %c, first string: %s, second string: %s\n"
pof52:					.string 			"length: %d, string: %s\nlength: %d, string: %s\n"
scanC: 				.string 			"\n%c %c"
scanNums :			.string 			"\n%d\n%d"
errormsg: 				.string 			"invalid option!\n"
errormsg2: 			.string 			"invalid input!\n"
print:					.string			"f:%d, s:%d\n"
print1:					.string			"f:%d\n"
swapP:					.string 			"length: %d, string: %s\nlength: %d, string: %s\n"
cmpP:					.string 			"compare result: %d\n"
errorcp:				.string			"invalid input!\ncompare result: %d\n"
erop:					.string 			"invalid option!\n"
testing:					.string			"op)%d \t pstr1)%s \t pstr2)%s\n"
.L10:
    .quad .L0 		#option 50
    .quad .L1 		#option 51
    .quad .L2 		#option 52
    .quad .L3 		#option 53
    .quad .L4 		#option 54
	.quad .L5 		#option DONE
.text
.global run_func
run_func:
	pushq	%rbp			#save the old frame pointer
    mov		%rsp, %rbp	#create the new frame pointer
######################start of code######################
	leaq		-50(%rdi),%rdi 	#the operation num comes in RDI
	cmpq	$4, %rdi   				#compare xi:4 becouse our range is 51/52/53/54
    jg 			.L6  						#big than 4 so go to default
    cmpq	$0, %rdi   				#0>rdi?
    jl 			.L6  						#error
	jmp 		*.L10(,%rdi,8)		#goto write case
	ret
###########################################################################
.L0:									 #option 50
	xorq		%rax, %rax 		#inition RAX
	movq	(%rsi), %rax		#move the first pstring to RAX
	call pstrlen					#check the len
	movq 	%rax, %r12 		#save the answer from RAX for later.
	xorq 		%rax, %rax 		#inition RAX
	movq 	(%rdx), %rax		#move the second pstring to RAX
	call pstrlen						#check the len
	movq 	%rax, %rdx		#save the answer in RDX in order to print second
	movq 	%r12,%rsi			#restore the first len in order to print first
	xorq 		%r12, %r12		#inition the R12 after using.
	mov 		$strlenP, %rdi 	#format to RDI
	xorq 		%rax, %rax		#init RAX
	call 		printf					#print
	jmp .L5							#done
###########################################################################
.L1: 									#option 51
	movq	%rsi, %r12		#backUp pstr1
	movq 	%rdx, %r13		#backUp pstr2
	xorq		%rax, %rax		#init RAX
	xorq 		%rdi, %rdi		#init RDI
	movq 	$scanC, %rdi	#scanf format
	subq 	$2, %rsp			#allocate place to the chars
	leaq 		1(%rsp), %rsi	#RSI point to place of the first scanf
	movq 	%rsp, %rdx		#RDX point to place of the second scanf
	call scanf
	movq 	1(%rsp), %rsi	#set the pointer to the input
	movq 	(%rsp), %rdx
	xorq 		%rax, %rax		#init RAX
	movq 	%r12, %rdi		#move pstr1 to RDI (to the function)
	call replaceChar
	movq 	%rax, %r12		#move the answer to print place
	xorq 		%rdi, %rdi
	movq 	%r13, %rdi		#move pstr2 to RDI (to the function)
	xorq 		%rax, %rax
	call replaceChar
	movq 	%rax, %r13			#move the answer to print place
	mov 	$replaceCharP, %rdi #format to RDI
	leaq 		1(%r12), %rcx		#mov the pstring1 adrees (-1 to delete the len) to print place
	leaq 		1(%r13), %r8		# ---"--- (pstring2)
	xorq 		%rax, %rax			#init RAX
	call printf							#print
	xorq 		%rax, %rax			#init RAX
	addq 	$2, %rsp				#restore the original RSP
	jmp .L5
###########################################################################	
.L2: 								#option 52
	movq	%rsi, %r12				#backUp pstr1
	movq 	%rdx, %r13				#backUp pstr2
	xorq 		%rax, %rax				#init RAX
	xorq 		%rdi, %rdi				#init RDI
	subq 	$16, %rsp					#allocate place to the nums(8 bytes per num)
	movq 	$scanNums, %rdi		#scanf format
	leaq 		8(%rsp), %rsi			#RSI point to place of the first scanf
	movq	%rsp, %rdx				#RDX point to place of the second scanf
	call scanf
	movq 	(%rsp), %r9		#take the value of j to R9
	movq 	8(%rsp), %r8	#take the value of i to R8
	xorq 		%rax, %rax 		#inition RAX
	movq 	(%r12), %rax	#move pstring1 to RAX
	call pstrlen						#check the len
	movq 	%rax, %r14		#save pstr1Len in R14
	xorq 		%rax, %rax 		#inition RAX
	movq 	(%r13), %rax	#move the second pstring to RAX
	call pstrlen						#check the len
	movq	 %rax, %r15		#save pstr2len.
	######start of validation#####
	cmpl 	$0, %r8d			#check if i<0
	jl 			.error				#jump to error
	cmpl 	$0, %r9d			#check if j<0
	jl 			.error				#jump to error
	cmpl 	%r9d, %r8d		#check if j<i , r9<r8
	jg 			.error				#jump to error
	cmpl 	%r14d, %r9d		#check if pstrlen1 < j 
	jge 		.error				#jump to error
	cmpl		 %r15d, %r9d		#check if pstrlen2 < j
	jge 		.error				#jump to error
			#####end of validation######
	xorq 		%rcx, %rcx		#init RCX for the char
	movl		%r9d, %ecx		#move j to ecx (par 4) 
	xorq 		%rdx, %rdx		#init RDX for the char
	movl		%r8d, %edx		#move i to edx (par 3)
	movq	%r12, %rdi		#move pstr1 (par 1)
	movq 	%r13, %rsi		#move pstr2 (par 2)
	xorq 		%rax, %rax		#inition rax
	call pstrijcpy
	movq	 %rax, %rdx		#move the answer to RDX
.con52:
	movq 	%r14, %rsi		#move pstr1Len to RSi
	movq 	%r15 ,%rcx		#mov pstr2len to rcx
	movq 	%r13 , %r8		#move pstr2 to r8
	addq		$1, %r8			#del the len
	movq 	$pof52, %rdi		#move print format to RDI
	xorq 		%rax, %rax		#inition rax
	call printf
	jmp 		.endof52
.error:									#Error in validation
	movq 	$errormsg2, %rdi	#format print to RDI
	xorq 		%rax, %rax
	call printf
	xorq 		%rax, %rax
	addq $1, %r12
	movq %r12, %rdx				#print R12
	jmp .con52
.endof52:
	addq 	$8, %rsp		#restore the original RSP
	jmp 		.L5				#jump to DONE
###########################################################################
.L3: 											#option 53
	movq 	%rdx, %r13		#save pstr1 in r12
	movq 	%rsi, %r12		#save pstr2 in r13
	movq 	(%r12), %rax	#move pstring1 to RAX
	call pstrlen						#check the len
	movq 	%rax, %r11		#save pstr1len in R14
	movq 	(%r13), %rax	#move pstring2 to RAX
	call pstrlen						#check the len
	movq 	%rax, %r14		#save pstr2len in R11
	movq 	%r12, %rdi		#pstr1 saved in R12 so we put him in RDI
	xorq 		%rax, %rax
	call swapCase
	movq 	%rax, %rsi		#save the answer in Rsi
	movq 	%r13, %rdi		# put pstr2 in RDI
	xorq 		%rax, %rax
	call swapCase
	movq 	%rax, %r8			#answer to R8 (print place)
	addq    $1,%r8				#+1 to delete the len
	movq 	%rsi, %rdx		#pstr1 to print place
	addq 	$1, %rdx			#delete the len from pstr1
	movq 	%r11, %rsi		#pstrlen1 to print place
	movq 	%r14,%rcx		#pstrlen2 to print place
	movq 	$swapP ,%rdi	#print format
	xorq 		%rax, %rax				
	call printf						#formt(rdi), flen(rsi), pstr1(rdx), slen(rcx), pstr2(r8)
	jmp 		.L5					#jump to DONE
###########################################################################
.L4: 								#option 54
	movq 	%rsi, %r12				#backUp pstr1
	movq 	%rdx, %r13				#backUp pstr2
	xorq 		%rax, %rax				#init RAX
	xorq 		%rdi, %rdi				#init RDI
	subq 	$16, %rsp					#allocate place to the nums(8 bytes per num)
	movq 	$scanNums, %rdi		#scanf format
	leaq 		8(%rsp), %rsi			#RSI point to place of the first scanf
	movq 	%rsp, %rdx				#RDX point to place of the second scanf
	call scanf
	movq 	(%rsp), %rdx			#take the value of j to RDX
	movq 	8(%rsp), %rsi			#take the value of i to RSI
		#####start of validation####
	cmpl 	$0, %esi			#check if i<=0
	jl 			.errorc				#jump to error
	cmpl 	$0, %edx			#check if j<0
	jl 			.errorc				#jump to error
	cmpl 	%edx, %esi		#check if j<i , edx<esi
	jg 		.errorc				#jump to error
	movq 	%rsi, %r11		#save RSI (=i) in r11
	xorq 		%rax, %rax 		#inition RAX
	movq 	(%r12), %rax	#move pstring1 to RAX
	call pstrlen					#check the len
	cmpl 	%eax, %edx		#check if pstrlen1 < j
	jge 		.errorc				#jump to error
	movq 	%rax, %r14		#save pstr1Len in R14
	xorq 		%rax, %rax 		#inition RAX
	movq 	(%r13), %rax	#move the second pstring to RAX
	call pstrlen					#check the len
	movq 	%r11, %rsi		#move i (r11) to
	cmpl 	%eax, %edx		#check if pstrlen2 < j
	jge 		.errorc				#jump to error
	movq 	%rax, %r11		#save pstr2len.
	#########end of validation######
	xorq 		%rcx, %rcx		#init RCX for the char
	movl		%edx, %ecx		#move j to ecx (par 4) 
	xorq 		%rdx, %rdx		#init RDX for the char
	movl 		%esi, %edx		#move i to edx (par 3)
	movq 	%r12, %rdi		#move pstr1 (par 1)
	movq 	%r13, %rsi		#move pstr2 (par 2)
	xorq 		%rax, %rax		#inition rax
	call pstrijcmp
	movq 	%rax, %rsi		#answer to print
	movq 	$cmpP, %rdi		#print format
	xorq 		%rax, %rax
	call printf
	jmp 		.L5					#jump to DONE
.errorc:
	movq 	$errorcp, %rdi
	movl 		$-2, %esi			#value of error case
	xorq 		%rax, %rax
	call printf
	jmp 		.L5					#jump to DONE
########################################################################	
.L6:								#Error in operation
	movq 	$erop, %rdi
	xorq 		%rax, %rax
	call printf
	xorq 		%rax, %rax
	jmp 		.L5					#jump to DONE
###########################################################################
.L5: 					#done
    movq	$0, %rdi			#return value is zero
    movq	%rbp, %rsp		#restore the old stack pointer - release all used memory.
    pop		%rbp				#restore old frame pointer (the caller function frame)
    ret	
#########################################################################
