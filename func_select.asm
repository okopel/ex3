
.section .rodata

.L10:
    .quad .L0 #option 50
    .quad .L1 #option 51
    .quad .L2 #option 52
    .quad .L3 #option 53
    .quad .L4 #option 54


.text
.global main
main:
    movq %rsp, %rbp  #setUp
    pushq	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code

    mov $55,  %rax
    call run_func
    

##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	


run_func:
    leaq -50(%rax), %rsi #compare input-50=xi
    cmpq $4,%rsi #compare xi:4 becouse our range is 51/52/53/54
    ja .L5  #big than 4 so go to default
    jmp *.L10(,%rsi,8) #goto write case
    
.L0: #option 50
call pstrlen
jmp .L5
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
ret
