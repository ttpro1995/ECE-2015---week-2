#Thai Thien

.data
aa1:	.word	1
aa2:	.word	3
aa3:	.word	5
aa4:	.word	11
aa5:	.word	12
aa6:	.word	15
aa7:	.word	16
aa8:	.word	17
aa9:	.word	18
aa10:	.word	20
length:  .word  10
val:     .word  15



.text
main:
la $a0, aa1                 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
la $s2, val		#load address val into s2
lw $a2, ($s2)		#load arg val

jal binary_search	#call binary search 
 
add $a0, $v0,$0		#a0 = return value
addi $v0, $0,1          #v0 = 1 print integer
syscall			#print integer
	
addi $v0,$0,10		#v0 = 10 exit
syscall			#exit









#############################
#int binarysearch ( int * arr, int numofelements, int val )
# $a0 = *arr
# $a1 = numofelements
# $a2 = val


#int binarysearch ( int * arr, int numofelements, int val ){
#	int bottom = 0, top = numofelement - 1, mid;
#	while (bottom <= top) {
#		mid = (bottom + top) >> 1;
#		if (val == arr[mid])
#			return mid;
#		else if (key < arr[mid])
#			top = mid - 1;
#		else
#			bottom = mid + 1;
#	}
#	
#	return -1;
#}
binary_search_norercusion:
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

#int bottom = 0, top = numofelement - 1, mid;
addi $s6,$0,-1             #ret =-1
add $s0, $0, $0            # $s0 = bottom = 0
add $s7, $a1,$0            # $s7 = numofelement
addi $s7, $s7,-1           # $s7 = top = numofelement -1
add $s1 , $a2, $0          # $s1 = val #Thai Thien 1351040
add $s3, $a0, $0           #s3 = *arr = base address of array
# $s5 = mid

j whilecodition2
whileloop2:
add $s5,$s0,$s7     # mid = (bottom + top)
srl $s5,$s5,1       # mid = (bottom + top) >> 1 
#arr[mid]

add $t5,$s5,$s5  # $t5 = i*2
add $t5,$t5,$t5  # $t5 = i*4
add  $t5,$t5,$s3  # t5 = address of arr[mid]
lw   $t1,($t5)   # $t1 = arr[mid]
beq  $t1,$s1,found2   #if (val == arr[mid])
#Thai Thien 1351040
slt $t0,$s1, $t1  # (key < arr[mid] t0 =1
bne $t0,$0, valsmallermid2


#else
addi $s0, $s5,1 #bottom = mid + 1;	
j whilecodition2  # jump to while condition
				
# if (key < arr[mid])
#			top = mid - 1;

valsmallermid2:
addi $s7, $s5,-1 #top = mid - 1;

whilecodition2:
slt $t0,$s7,$s0  # (bottom <= top)== not (top < bottom ), t0 = 0 when bottom <= top
beq $t0,$0,whileloop2		#if (bottom <=top) continue while loop


      

           
      
      
      
      
      
found2:      # return mid;
addi $s6, $t1, 0        #ret = i 

notfound2:
#do nothing 

add $v0,$s5,$0            #return ret


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
