
.section .rodata
strlenP: .string "first pstring length: %d, second pstring length: %d\n"
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
    ja .L5  								#big than 4 so go to default
   
	jmp *.L10(,%rdi,8) 			#goto write case
	ret
	
	
	
.L0: #option 50

	xorq %rax, %rax 		#inition RAX
	movq (%rsi), %rax		#move the first pstring to RAX
	call pstrlen					#check the len
	movq %rax, %r12 		#save the answer from RAX for later.
	
	xorq %rax, %rax 		#inition RAX
	movq (%rdx), %rax	#move the second pstring to RAX
	call pstrlen					#check the len

	movq %r12,%rdx		#restore the first len in order to print
	xorq %r12, %r12		#inition the R12 after using.
	mov $strlenP, %rdi 	#format to RDI

	xorq %rax, %rax			
	call printf						#print
jmp .L5							#done

.L1: #option 51
	
call replaceChar

jmp .L5

.L2: #option 52
call pstrijcpy

jmp .L5

.L3: #option 53

call swapCase

jmp .L5

.L4: #option 54
call pstrijcmp

jmp .L5

.L5: #done


	
	
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    pop	%rbp		#restore old frame pointer (the caller function frame)
    ret	
