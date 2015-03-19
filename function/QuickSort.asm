
#Thai Thien

.data
aa1:	.word	1
aa2:	.word	3
aa3:	.word	2
aa4:	.word	15
aa5:	.word	12
aa6:	.word	25
aa7:	.word	17
aa8:	.word	16
aa9:	.word	18
aa10:	.word	20
length:  .word  10
val:     .word  15

asc: .word 0


.text
main:
la $a0, aa1                 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
la $s2, asc		#load address asc into s2
lw $a2, ($s2)		#load arg asc
jal quicksort	#call quicksort

la $a0,aa1 		 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
jal printArray          #print out sorted array

addi $v0,$0,10		#v0 = 10 exit
syscall			#exit




###########################################

quicksort:
#store saved register
addi $sp, $sp, -32   # decrease stack pointer by 32 byte all 8 register
sw $s0, 28($sp)    #store $s0
sw $s1, 24($sp)	#store $s1
sw $s2, 20($sp)#store $s2
sw $s3, 16($sp)#store $s3
sw $s4, 12($sp)#store $s4
sw $s5, 8($sp)#store $s5
sw $s6, 4($sp)#store $s6
sw $s7, 0($sp)#store $s7

addi $sp, $sp, -12 # decrease stack pointer by 12 byte
sw $a1, ($sp)    #store $a1 in stack   
sw $a2, 4($sp)     #store $a2 in stack
sw $ra, 8($sp)	#store $ra in stack
addi $a2,$0, 0       #init $a2 =0
addi $a1, $a1, -1    #decrease $a1 by 1
jal requicksort       # run recusion quicksort
lw $a1, ($sp)         #restore $a1
lw $a2, 4($sp)		#restore $a1
lw $ra, 8($sp)	#restore $ra
addi $sp, $sp, 12      #adjust stack pointer
bne $a2, $0, E5        # if $a2 not zero, branch to E5
add $s0, $a0, $0    
add $s1, $a1, -1
sll $s1, $s1, 2
add $s1, $a0, $s1
add $s2, $a1, $0
div $s2, $s2, 2
B7:
lw $s3, ($s0)
lw $s4, ($s1)
sw $s3, ($s1)
sw $s4, ($s0)
addi $s0, $s0, 4
addi $s1, $s1, -4
addi $s2, $s2, -1
bne $s2, $0, B7
E5:


#restore saved register
sw $s7, 0($sp)#store $s0
sw $s6, 4($sp)#store $s1
sw $s5, 8($sp)#store $s2
sw $s4, 12($sp)#store $s3
sw $s3, 16($sp)#store $s4
sw $s2, 20($sp)#store $s5
sw $s1, 24($sp)#store $s6
sw $s0, 28($sp)#store $s7
addi $sp,$sp,32  #increase stack pointer  by 32 byte
jr $ra


################################################
requicksort:
addi $sp, $sp, -32   # decrease stack pointer by 32 byte all 8 register
sw $s0, 28($sp)    #store $s0
sw $s1, 24($sp)	#store $s1
sw $s2, 20($sp)#store $s2
sw $s3, 16($sp)#store $s3
sw $s4, 12($sp)#store $s4
sw $s5, 8($sp)#store $s5
sw $s6, 4($sp)#store $s6
sw $s7, 0($sp)#store $s7

addi $sp, $sp, -16
sw $s0, ($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)
sw $ra, 12($sp) 
slt $t0, $a2, $a1
beq $t0, 0, E6
jal partition
add $s0, $v0, $zero
addi $a1, $s0, -1
jal requicksort
lw $a1, 4($sp)
addi $a2, $s0, 1
jal requicksort
E6:
lw $s0, ($sp)
lw $a1, 4($sp)
lw $a2, 8($sp)
lw $ra, 12($sp) 
addi $sp, $sp, 16



#restore saved register
sw $s7, 0($sp)#store $s0
sw $s6, 4($sp)#store $s1
sw $s5, 8($sp)#store $s2
sw $s4, 12($sp)#store $s3
sw $s3, 16($sp)#store $s4
sw $s2, 20($sp)#store $s5
sw $s1, 24($sp)#store $s6
sw $s0, 28($sp)#store $s7
addi $sp,$sp,32  #increase stack pointer  by 32 byte
jr $ra


#################################################
partition:
addi $sp, $sp, -32   # decrease stack pointer by 32 byte all 8 register
sw $s0, 28($sp)    #store $s0
sw $s1, 24($sp)	#store $s1
sw $s2, 20($sp)#store $s2
sw $s3, 16($sp)#store $s3
sw $s4, 12($sp)#store $s4
sw $s5, 8($sp)#store $s5
sw $s6, 4($sp)#store $s6
sw $s7, 0($sp)#store $s7


add $s0, $a0, $0
add $s1, $a1, $0
sll $s1, $s1, 2
add $s1, $a0, $s1
add $s2, $a2, $0
sll $s2, $s2, 2
add $s2, $a0, $s2
add $s3, $a1, $0
sub $a1, $a1, $a2
li $v0, 42
syscall
add $a1, $s3, $0
add $s3, $a0, $a2
add $a0, $s0, $0
add $s0, $s3, $0
sll $s0, $s0, 2
add $s0, $a0, $s0
lw $s0, ($s0)
L6:
slt $s3, $s2, $s1
bne $s3, 1, E7
L7:
lw $s3, ($s2)
slt $s4, $s3, $s0

beq $s4,$0,L8#
addi $s2, $s2, 4
j L7
L8:
lw $s3, ($s1)
slt $s4, $s0, $s3

beq $s4,$0,L9#
addi $s1, $s1, -4
j L8
L9:
lw $s4, ($s2)
bne $s4, $s3, I1
add $s2, $s2, 4
j L9
I1:
slt $s5, $s2, $s1
beq $s5,$0,E7#
sw $s4, ($s1)
sw $s3, ($s2)
j L6
E7:
sub $v0, $s1, $a0
srl $v0, $v0, 2


#restore saved register
sw $s7, 0($sp)#store $s0
sw $s6, 4($sp)#store $s1
sw $s5, 8($sp)#store $s2
sw $s4, 12($sp)#store $s3
sw $s3, 16($sp)#store $s4
sw $s2, 20($sp)#store $s5
sw $s1, 24($sp)#store $s6
sw $s0, 28($sp)#store $s7
addi $sp,$sp,32  #increase stack pointer  by 32 byte
jr $ra  #return
#################################
printArray:
# $a0 arr
# $a1 length
addi $sp, $sp, -32   # decrease stack pointer by 32 byte all 8 register
sw $s0, 28($sp)    #store $s0
sw $s1, 24($sp)	#store $s1
sw $s2, 20($sp)#store $s2
sw $s3, 16($sp)#store $s3
sw $s4, 12($sp)#store $s4
sw $s5, 8($sp)#store $s5
sw $s6, 4($sp)#store $s6
sw $s7, 0($sp)#store $s7


add $s0,$a0,$0  #s0 = base address of arr
add $s1,$a1,$0  #s1 = length
addi $s6,$0,8   #space bar
addi $s2,$0,0  # $s2 = i = 0
j forPrint
forPrintLoop:
#for (int i=0;i<length;i++)
 # print(a[i])
add $t5,$s2,$s2  # t5 =i*2
add $t5,$t5,$t5  # t5 = 4*t5
add $t5,$t5,$s0   #t5 = address of arr[i]
lw  $t6,($t5)    #t6 = arr[i]

add $a0,$t6,$0 #load arr[i] into $a0 to print
addi $v0,$0,1  # $v0 = 1 print int

addi $sp,$sp,-4 #adjust stack pointer
sw $ra,($sp)     #store $ra
syscall   #print arr[i]

jal new_line  # go to new line

lw $ra,($sp)   #restore %ra
addi $sp,$sp,4    #adjust stack pointer

 
addi $s2,$s2,1   #increase i   
forPrint:
slt $t0,$s2,$s1  # i<length then $t0 =1
bne $t0, $0, forPrintLoop #continue loop

#restore saved register
sw $s7, 0($sp)#store $s0
sw $s6, 4($sp)#store $s1
sw $s5, 8($sp)#store $s2
sw $s4, 12($sp)#store $s3
sw $s3, 16($sp)#store $s4
sw $s2, 20($sp)#store $s5
sw $s1, 24($sp)#store $s6
sw $s0, 28($sp)#store $s7
addi $sp,$sp,32  #increase stack pointer  by 32 byte

jr $ra

#########################
############new_line############
new_line: # go to next line
addi $sp,$sp,-4 # decrease $sp by 4
addi $t0,$0,10  # $t0 = 10 = LF ascii code
sw $t0,0($sp) #store LF into stack
addi $a0,$sp,0  #$a0 = address of LF 
addi $v0,$0,4	# $v0=4, print_string
syscall		#print_string 
addi $sp,$sp,4 # increase $sp by 4
jr $ra

#########################