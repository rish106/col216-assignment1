.data

.text
main: 

    li $v0,5
    syscall
    add $a2,$v0,$zero  #Taking base input

    li $v0,5
    syscall
    add $a3,$v0,$zero  #Taking exponent input

    addi $sp,$sp,-4
    sw $ra,0($sp)
    jal binexp
    lw $ra,0($sp)
    addi $sp,$sp,4

    li $v0,1
    add $a0,$v1,$zero
    syscall

    jr $ra


#Starting the function

binexp:

#a2 and a3 would always be storing the base and exponent respectively during
#each function call

    beq $a3,$zero,Basecase     #the base case of the recursion is when the exponent is 0

    addi $sp,$sp,-8
    sw $ra,0($sp)
    sw $a3,4($sp)   #Store the current values of ra and a3 on the stack

    srl $a3,$a3,1  #change the value of exponent to floor(exponent/2)
    jal binexp

    lw $a3,4($sp)
    lw $ra,0($sp)
    addi $sp,$sp,8 #Restore the saved values in the respective registers

    andi $t0,$a3,1
    li $t1,1    #To check the parity of a3, we check its bitwise AND with 1
    beq $t0,$t1,Oddcase     #If AND is 1, the exponent is odd
    beq $t0,$zero,Evencase  #Else it is even
   
Basecase:

    li $v1,1
    jr $ra

Oddcase:

    mul $v1,$v1,$v1
    mul $v1,$v1,$a2   #We know a2^((a3-1)/2) and we are finding $a2^a3$ from that
    jr $ra

Evencase:

    mul $v1,$v1,$v1  #We know a2^(a3/2) and we are finding $a2^a3$ from that
    jr $ra


    


