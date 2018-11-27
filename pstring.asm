.data
format: .string "%s\n"
formatStrLen: .string "first pstring length: %d, second pstring length: %d\n"

input: .string "842"
.text
.global replaceChar
.global pstrijcpy
.global main
main:
    movq %rsp, %rbp  #setUp
    pushq %rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code
    mov $input,%rax
    mov $3,%r12
    mov $4,%r13

    #call pstrlen
       #mov %rax,%rsi
    #mov %rbx,%rdx
    #movq $0, %rax
    #mov $formatStrLen, %rdi #set the format of input
    #call printf
   
   
##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret


pstrlen:
    pushq %rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code
    mov %r12,%rax
    mov %r13,%rbx
    #mov (%rsi),%al #set the input
    #mov %al,(%rax)
  
  
##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret #end of pstrlen

replaceChar:

ret

pstrijcpy:
ret

swapCase:
ret


pstrijcmp:
ret
