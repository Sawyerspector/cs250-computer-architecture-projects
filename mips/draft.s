.data

p_name: .asciiz "Player last name?\n"
p_college: .asciiz "College?\n"
p_team: .asciiz "Team?\n"

sep_colon: .asciiz ": "
sep_comma: .asciiz ", "
nl: .asciiz "\n"
done_str: .asciiz "DONE"

namebuf: .space 64
collegebuf: .space 64
teambuf: .space 64


.text

.globl main



main:
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $ra, 12($sp)

    move $s0, $zero
    li $s1, 1

read_loop:
    #Read the last name
    li $v0, 4
    la $a0, p_name
    syscall

    li $v0, 8
    la $a0, namebuf
    li $a1, 64
    syscall
    la $a0, namebuf
    jal strip_nl

    #if name equals DONE, break
    la $a0, namebuf
    la $a1, done_str
    jal strcmp
    bnez $v0, read_college
    b done_input

read_college:
    #read college
    li $v0, 4
    la $a0, p_college
    syscall

    li $v0, 8
    la $a0, collegebuf
    li $a1, 64
    syscall
    la $a0, collegebuf
    jal strip_nl

    #read team
    li $v0, 4
    la $a0, p_team
    syscall

    li $v0, 8
    la $a0, teambuf
    li $a1, 64
    syscall
    la $a0, teambuf
    jal strip_nl

    #allocate node
    li $v0, 9
    li $a0, 200
    syscall

    move $s2, $v0

    #node -> next = NULL
    sw $zero, 196($s2)

    #node -> draftPosition = pick;pick++
    sw $s1, 128($s2)
    addi $s1, $s1, 1

    #copy namebuf -> node -> name
    la $a0, namebuf
    addiu $a1, $s2, 64
    jal strcpy

    #copy collegebuf -> node -> college
    la $a0, collegebuf
    addiu $a1, $s2, 0
    jal strcpy

    #copy teambuf -> node -> team
    la $a0, teambuf
    addiu $a1, $s2, 132
    jal strcpy

    #head = insertSorted(head, node)
    move $a0, $s0
    move $a1, $s2
    jal insertSorted
    move $s0, $v0

    b read_loop

done_input:
    move $t0, $s0

print_loop:
    beq $t0, $zero, end_main

    #print college
    li $v0, 4
    addiu $a0, $t0, 0
    syscall

    # print ": "
    li $v0, 4
    la $a0, sep_colon
    syscall

    # print name
    li $v0, 4
    addiu $a0, $t0, 64
    syscall

    # print ", "
    li $v0, 4
    la $a0, sep_comma
    syscall

    # print draftPosition
    li $v0, 1
    lw $a0, 128($t0)
    syscall

    # print ", "
    li $v0, 4
    la $a0, sep_comma
    syscall

    #print team
    li $v0, 4
    addiu $a0, $t0, 132
    syscall

    #newline
    li $v0, 4
    la $a0, nl
    syscall

    #advance cur = cur -> next
    lw $t0, 196($t0)
    b print_loop

end_main:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    li $v0, 10
    syscall


strcmp:

strcmp_loop:

    lb $t0, 0($a0)
    lb $t1, 0($a1)
    bne $t0, $t1, strcmp_diff
    beq $t0, $zero, strcmp_eq
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    b strcmp_loop

strcmp_diff:
    sub $v0, $t0, $t1
    jr $ra
strcmp_eq:
move $v0, $zero
jr $ra

strcpy:
    move $v0, $a1
cpy_loop:
    lb $t0, 0($a0)
    sb $t0, 0($a1)
    beq $t0, $zero, cpy_done
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    b cpy_loop
cpy_done:
    jr $ra

strip_nl:
sn_loop:
    lb $t0, 0($a0)
    beq $t0, $zero, sn_done
    addi $t1, $zero, 10
    bne $t0, $t1, sn_next
    sb $zero, 0($a0)
    jr $ra
sn_next:
    addi $a0, $a0, 1
    b sn_loop
sn_done:
    jr $ra

node_cmp:
    
    addi $sp, $sp, -12
    sw $a1, 0($sp)
    sw $a0, 4($sp)
    sw $ra, 8($sp)
    lw $t0, 4($sp)
    lw $t1, 0($sp)
    move $a0, $t0
    move $a1, $t1
    jal strcmp
    bnez $v0, nc_ret
    lw $t0, 4($sp)
    lw $t1, 0($sp)

    lw $t2, 128($t0)
    lw $t3, 128($t1)
    sub $v0, $t2, $t3

nc_ret:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

insertSorted:
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s2, 12($sp) #head
    sw $s3, 8($sp) #prev
    sw $s4, 4($sp) #cur
    sw $s5, 0($sp)

    move $s2, $a0
    move $s5, $a1
    move $s3, $zero
    move $s4, $a0
    #save ra and working saved regs
    #if head == NULL OR node_cmp(new, head) < 0 -> insert at head

    beq $s4, $zero, ins_at_head
    move $a0, $s5
    move $a1, $s4
    jal node_cmp
    bltz $v0, ins_at_head

    
ins_loop:
    beq $s4, $zero, ins_after_cur
    
    lw $t0, 196($s4)
    beq $t0, $zero, ins_after_cur
    move $a0, $s5
    move $a1, $t0
    jal node_cmp
    bltz $v0, ins_between
    
    move $s3, $s4
    lw $t0, 196($s4)
    move $s4, $t0
    b ins_loop

ins_at_head:
    sw $s2, 196($s5)
    move $v0, $s5
    b ins_done

ins_after_cur:
    sw $zero, 196($s5)
    beq $s4, $zero, ins_make_head
    sw $s5, 196($s4)
    move $v0, $s2
    b ins_done

ins_between:
    lw $t0, 196($s4)
    sw $t0, 196($s5)
    beq $s4, $zero, ins_make_head
    sw $s5, 196($s4)
    move $v0, $s2
    b ins_done
    
#ins_link:
#    sw $s4, 196($s5)
#    beq $s3, $zero, ins_make_head
#    sw $s5, 196($s3)
#    move $v0, $s2
#    b ins_done
    
ins_make_head:
    move $v0, $s5
ins_done:

    lw $s5, 0($sp)
    lw $s4, 4($sp)
    lw $s3, 8($sp)
    lw $s2, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    jr $ra
