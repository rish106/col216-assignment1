    .data                   # data segment
n:      .word 0                     # variable to store the input integer

    .text                   # code segment
    .globl main             # declare main function as global entry point

main:
    # read integer input
    li $v0, 5               # syscall code for reading an integer
    syscall                 # make the syscall
    sw $v0, n               # store input value in variable n

    # print input value
    li $v0, 1               # syscall code for printing an integer
    lw $a0, n               # load input value from variable n into $a0
    syscall                 # make the syscall

    # exit program
    # li $v0, 10              # syscall code for exit
    # syscall                 # make the syscall
    jr $ra
