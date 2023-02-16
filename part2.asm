.data
n: .word 0
x: .word 0

msg_success: .asciiz "Found at index "
msg_failure: .asciiz "Not found\n"
new_line: .asciiz "\n"

.text
.globl main

main:
    li $v0, 5
    syscall
    sw $v0, n
    lw $s2, n # s2 = n
    li $t0, 0 # loop invariant
    add $t1, $s2, $zero
    sll $t1, $t1, 2
    add $a0, $t1, $zero
    li $v0, 9
    syscall
    add $s4, $v0, $zero
    add $t1, $v0, $zero
    j input_loop

input_loop:
    li $v0, 5
    syscall
    sw $v0, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, 4
    blt $t0, $s2, input_loop # loop if t0 < n
    j input_x

input_x:
    li $v0, 5
    syscall
    sw $v0, x # store the input integer at the address of x
    lw $s1, x # s1 = x
    lw $s3, n # s3 = n (right bound)
    li $s5, 0 # s5 = 0 (left bound)
    j binary_search

# s5 = l (left bound), s3 = r (right bound)
# initially l = 0 and r = n
binary_search:
    add $s0, $s5, $s3 # s0 = l+r
    srl $s0, $s0, 1 # s0 = floor((l+r)/2)
    sll $s0, $s0, 2 # s0 = 4*floor((l+r)/2)
    add $t5, $s4, $s0 # t5 = base address of array + 4*floor((l+r)/2)
    lw $t6, 0($t5) # t6 = a[floor((l+r)/2)]
    beq $t6, $s1, found
    blt $t6, $s1, shift_left_bound # if a[i] < x, update l
    j shift_right_bound # else update r

shift_left_bound:
    srl $s0, $s0, 2 # s0 = floor((l+r)/2)
    addi $s5, $s0, 1 # l = i+1
    blt $s5, $s3, binary_search # loop if l < r
    j not_found

shift_right_bound:
    srl $s0, $s0, 2 # s0 = i = floor((l+r)/2)
    add $s3, $s0, $zero # r = i
    blt $s5, $s3, binary_search # loop if l < r
    j not_found

not_found:
    # print "Not found"
    li $v0, 4
    la $a0, msg_failure
    syscall
    jr $ra

found:
    # print "Found at index i"
    li $v0, 4
    la $a0, msg_success
    syscall
    li $v0, 1
    srl $a0, $s0, 2
    syscall
    li $v0, 4
    la $a0, new_line
    syscall
    jr $ra
