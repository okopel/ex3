.section .data
x: .string "\n oper: %d \n \n \n \n "
y: .string "\n \n \n test: print %d \n \n \n \n "
z: .long 77
strlens: .string "\n first string is: %d %d  \n"
w: .string "moshe \n"


.text

.global pstrlen
.global replaceChar
.global pstrijcpy
.global swapCase
.global pstrijcmp

   



pstrlen: # option 50
    
	#mov %rsi,%r12
	
	
	
	
	
	
	movq (%rsi), %rax
	xorq %rsi, %rsi
	movb %al, %sil
	#oper comes in RDI psrt1 comes in RSI and pstr2 comes in RDX
	mov $strlens, %rdi #RDI is the format from the print
	xorq %rax, %rax
	#call printf
	
	
	#xorq %rbx, %rbx
	movq (%rdx), %rbx #move the oper from RDI to RCX
	#xorq %rbx, %rsi
	xorq %rdx, %rdx
	movb %bl, %dl
	mov $strlens, %rdi #RDI is the format from the print
	#######RAX	RCX	RDX	RBX	(RSP	RBP)	RSI	RDI###
	xorq %rax, %rax
	call printf
	
	
	#mov %rdi, %rcx #move the oper from RDI to RCX
	#mov $strlens, %rdi #RDI is the format from the print
	#mov $0, %rax
	#call printf

##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	

replaceChar: #option 51
	movq %rsp, %rbp  #setUp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code




##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	

pstrijcpy: #option 52
	movq %rsp, %rbp  #setUp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code




##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	

swapCase: #option 53
	movq %rsp, %rbp  #setUp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code

	#print to check arrived
	mov %rdi, %rsi #rsi is the first arg to print
	mov $x, %rdi #RDI is the format from the print
	#######RAX	RCX	RDX	RBX	RSP	RBP	RSI	RDI###
	mov $0, %rax
	call printf


##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	


pstrijcmp: #option 54
	movq %rsp, %rbp  #setUp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code




##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	
