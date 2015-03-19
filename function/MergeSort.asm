
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

asc: .word 1


.text
main:
la $a0, aa1                 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
la $s2, asc		#load address asc into s2
lw $a2, ($s2)		#load arg asc
jal mergesort	#call binary search 

la $a0,aa1 		 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
jal printArray          #print out sorted array

addi $v0,$0,10		#v0 = 10 exit
syscall			#exit


###########################################################
#int * MergeSort ( int * arr, int numofelements, bool asc ) ;
# $a0 = int *arr
# $a1 = int numofelements
# $a2 = bool asc
#store saved register
mergesort:
# base case of recursion
slti $t0, $a1, 2									# if(numofelements < 2) $t0 = 1 else $t0 = 0
beq $t0, $zero, merge_sort_begin							# if($t0 == 0) goto merge_sort_begin
add $v0, $a0, $zero									# return value = address of arr
jr $ra											# return to caller
	
merge_sort_begin:									# begin doing merge sort
addi $sp, $sp, -16									# adjust $sp to get 16 bytes in the stack
sw $ra, 0($sp)										# Memory[$sp + 12] = $ra				
sw $s0, 4($sp)										# Memory[$sp + 8] = $s0
sw $s1, 8($sp)										# Memory[$sp + 4] = $s1
sw $a0, 12($sp)										# Memory[$sp] = $a0
	
srl $s0, $a1, 1										# $s0 = med = numofelements/2 (shift right by 1)
sub $s1, $a1, $s0									# $s1 = numofelements - med
	
add $a1, $s0, $zero									# $a1 = med
jal mergesort										# call mergesort(arr, med, asc)			
	
sll $s0, $s0, 2										# $s0 = $s0 * 4 (shift left by 2)
add $a0, $a0, $s0									# $a0 = $a0 + $s0
add $a1, $s1, $zero									# $a1 = $s1
jal mergesort										# call mergesort(arr+med, numofelements - med, asc)
	
sll $s1, $s1, 2										# $s1 = $s1 * 4 (shift left by 2)	
add $a1, $s0, $s1									# $a1 = $s0 + $s1
	
lw $a0, 12($sp) 									# restore old $a0
lw $t0, 12($sp) 									# $t0 = base address of arr
add $t1, $t0, $s0 									# $t1 = $t0 + $s0
add $t2, $t0, $s0 									# $t2 = $t0 + $s0
add $t3, $t1, $s1 									# $t3 = $t1 + $s1

sub $sp, $sp, $a1									# adjust the stack pointer for temp[numofelements]
add $t4, $sp, $zero 									# $t4 = address of temp array

merge_sort_loop:
# In this loop we load elements from $t0 and $t1, each time put the smaller element into the temp array
lw $t5, 0($t0)										
lw $t6, 0($t1)
beq $t0, $t2, merge_sort_b								# there is no more element in $t0, put the remaining elements of $t1 in temp
beq $t1, $t3, merge_sort_a								# there is no more element in $t1, put the remaining elements of $t0 in temp
	
slt $t7, $t5, $t6									# if($t5 < $t6) $t7 = 1 else $t7 = 0
beq $t7, $a2, merge_sort_a								# if($t7 == asc) goto merge_sort_a
j merge_sort_b										# goto merge_sort_b
		
merge_sort_a:
beq $t0, $t2, merge_sort_end_loop							# if ($t0 == $t2) goto merge_sort_end_loop
sw $t5, 0($t4)										# store element into temp array
addi $t4, $t4, 4									# $t4 = $t4 + 4
addi $t0, $t0, 4									# $t0 = $t0 + 4
j merge_sort_loop									# goto merge_sort_loop
		
merge_sort_b:
beq $t1, $t3, merge_sort_end_loop							# if($t1 == $t3) goto merge_sort_end_loop
sw $t6, 0($t4)										# store element into temp array
addi $t4, $t4, 4									# $t4 = $t4 + 4
addi $t1, $t1, 4									# $t1 = $t1 + 4
j merge_sort_loop									# goto merge_sort_loop
					
merge_sort_end_loop:
	
add $t0, $a0, $a1									# $t0 = $a0 + $a1
merge_sort_copy:									# copy elements from temp back to the array arr
beq $a0, $t0, merge_sort_end_copy							# if($a0 == $t0) goto merge_sort_end_copy	
lw $t1, 0($sp)										# load element from temp array
sw $t1, 0($a0)										# store that element into the array arr 
addi $a0, $a0, 4									# $a0 = $a0 + 4
addi $sp, $sp, 4									# pop 4 bytes off the stack
j merge_sort_copy									# goto merge_sort_copy

merge_sort_end_copy:
lw $a0, 12($sp)										# restore old $a0
lw $s1, 8($sp)										# restore old $s1
lw $s0, 4($sp)										# restore old $s0
lw $ra, 0($sp)										# restore ol $ra 
addi $sp, $sp, 16
	
add $v0, $a0, $zero									# return value = address of arr
jr $ra											# return to caller



#################################
printArray:
# $a0 arr
# $a1 length

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
