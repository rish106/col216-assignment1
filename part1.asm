.text
.globl main

main:
    # Read the input string
    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall

    # Print the saved string
    li $v0, 4
    la $a0, buffer
    syscall

    # Exit
    li $v0, 10
    syscall

.data
buffer: .space 100
