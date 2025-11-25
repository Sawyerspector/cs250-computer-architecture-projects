.data
prompt: .asciiz "N?\n"
nl:     .asciiz "\n"

.text
.globl main

main:

    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    mul $t1, $t0, $t0
    mul $t2, $t1, $t0
    addi $t2, $t2, -3

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, nl
    syscall

    jr $ra


