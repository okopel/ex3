#ori kopel 205533151
.section .rodata

input: 		.string		 "%d\n%s\n%d\n%s\n%d"

.text
.global main
main:
	pushq	%rbp			#save the old frame pointer
    mov	%rsp,	%rbp	#create the new frame pointer
############################################start of code
	xorq %rax, %rax		#init rax
	movq $input, %rdi		#set the print format
	call scanf					#scan len, pstr1, len2, pstr2, oper
	
	
	xorq %rax, %rax		#init rax
	call run_func
	
	
	
	movq	$0, %rdi			#return value is zero
    movq	%rbp, %rsp		#restore the old stack pointer - release all used memory.
    pop	%rbp					#restore old frame pointer (the caller function frame)
    ret
####################################################################################
