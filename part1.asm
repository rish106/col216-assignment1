.text
.globl main

main:
    # allocate 100 bytes on heap for input string
    li $a0, 101
    li $v0, 9
    syscall

    # a0 = base address of string
    # take 100 character string input starting at address a0
    add $a0, $v0, $zero
    li $a1, 101
    li $v0, 8
    syscall

    # print string starting at base address a0
    li $v0, 4
    syscall
    jr $ra
