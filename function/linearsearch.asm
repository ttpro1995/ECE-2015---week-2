#Thai Thien

.data
aa1:	.word	1
aa2:	.word	3
aa3:	.word	5
aa4:	.word	11
aa5:	.word	12
aa6:	.word	15
aa7:	.word	4
aa8:	.word	6
aa9:	.word	8
aa10:	.word	20
length:  .word  10
val:     .word  15
###########
.text
main:
la $a0, aa1
la $s1, length
lw $a1, ($s1)
la $s2, val
lw $a2, ($s2)

jal linearsearch

add $a0, $v0,$0
addi $v0, $0,1
syscall

addi $v0,$0,10
syscall




#############################
.text
#int linearsearch(int * arr, int numofelements, int val)
# $a0 = *arr
# $a1 = numofelements
# $a2 = val
linearsearch:

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

addi $s6,$0,-1             #ret =-1
add $s0, $0, $0            # $s0 = i = 0
add $s7, $a1,$0            # $s7 = num of element
add $s1 , $a2, $0          # $s1 = val

loop1:
add $t1,$s0,$s0            # $t1 = $s0 *2 = i*2
add $t1, $t1,$t1           # $t1 = i*4
add $s2, $a0,$t1           # s2 = *arr + 4*i =arr[i]
lw $s3, ($s2)              # s3 = arr[i]
beq $s3,$s1,found1         # found arr[i] = val
addi $s0, $s0,1             #increase i by 1
bne $s0,$s7, loop1         #if i != num of element, jump to loop 1
j notfound1

found1:
addi $s6, $s0, 0        #ret = i 

notfound1:
add $v0,$s6,$0            #return ret


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


jr $ra			#return




########################
