.data
formatInt:  .string "%d"

.text
.global main
main:
    movq %rsp, %rbp #for correct debugging
    # write your code here
    push %rbp
    movq %rsp,%rbp
    
    subq $4,%rsp
    movq $0, %rax
    movq $formatInt, %rdi
    movq %rsp, %rsi
    call scanf
    movq $0, %rax
    call printf
    movq %rbp, %rsp
    pop %rbp
    ret
