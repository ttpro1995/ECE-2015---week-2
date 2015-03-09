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
jr $ra			#return



########################
