.data
format: .string "%d"
formatString: .string "%s"

enterFirst: .string "Enter first len\n"
outFirst: .string "you enterd %d  \n"

.text
.global main
main:
    movq %rsp, %rbp  #setUp
    push	%rbp		#save the old frame pointer
    movq	%rsp,	%rbp	#create the new frame pointer
###############start of code

    mov $enterFirst, %rdi #set the format of output.
    movq $0, %rax
    call printf
    
    subq $0x08, %rsp
    mov $0, %rax #clear rax
    mov $format, %rdi #set the format of input.
   # mov %rsp, %rsi #set storage to the adress
    call scanf
    call printf

   
   # movq %rbx,%rsi
    mov $outFirst, %rdi #set the format of output.
    movq $0, %rax
    call printf
    



##################end of code
    movq	$0, %rdi	#return value is zero
    movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
    popq	%rbp		#restore old frame pointer (the caller function frame)
    ret	
