.data
prompt: .asciiz "N?\n"
nl:     .asciiz "\n"

.text
.globl main

main:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $a0, $v0

    jal f

    move $t0, $v0
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, nl
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

f:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0

    beq $s0, $zero, f_base
    
    # termA = 2*(n+1)
    addi $t0, $s0, 1
    addu $s1, $t0, $t0

    #f(n-1)
    addi $a0, $s0, -1
    jal f
    move $t0, $v0

    #3 * f(n-1)
    mul $t0, $t0, 3

    #total = termA + termB + 9
    addu $v0, $s1, $t0
    addi $v0, $v0, 9
    j f_epilogue

f_base:
    li $v0, 2

f_epilogue:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

