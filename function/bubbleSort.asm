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

asc: .word 1


.text
main:
la $a0, aa1                 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
la $s2, asc		#load address asc into s2
lw $a2, ($s2)		#load arg asc
jal BubbleSort	#call bubble sort 

la $a0,aa1 		 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
jal printArray          #print out sorted array

addi $v0,$0,10		#v0 = 10 exit
syscall			#exit

############################
BubbleSort:
#int * bubblesort ( int * arr, int numofelements, bool asc ) ;
# $a0 = int *arr
# $a1 = int numofelements
# $a2 = bool asc
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

add $s0,$a0,$0 #$s0 = arr
add $s1,$a1,$0 #$s1 = num
add $s2,$a2,$0 #$s2 = asc
addi $s3,$0,1  # $s3 = flag =1
# $s4 = j


#void BubbleSort(int* arr, int num,bool asc)
#{
#	int  j, flag = 1;    // set flag to 1 to start first pass
#	int temp;             // holding variable
#Thai Thien 1351040


j while3 #check while condition		

whileLoop3:
#	while (flag)
#	{
add $s3,$0,$0	#		flag = 0;
#		for (j = 0; j < (num - 1); j++)
addi $s4,$0,0   #init j = 0
j for3
forLoop3:
#		{
bne $s2,$0,else3	#			if (asc == 0)
#			{
#				if (arr[j + 1] > arr[j])      // ascending order simply changes to <
addi $t4,$s4,1  #t4 = j+1  
sll  $t4,$t4,2  # t4 = (j+1)*4
add  $t4,$t4,$s0 #t4 = (j+1)*4 + base address of arr = address of arr[j+1]
addi $t3,$t4,-4  #t3 = (j)*4 + base address of arr = address of arr[j]
lw   $t5,($t3)   #t5 = arr[i]
#Thai Thien 1351040
lw   $t6,($t4)   #t6 = arr[i+1]
slt $t0,$t5,$t6  #if (arr[j + 1] > arr[j])  then t0 = 1
beq $t0,$0,noswapasc03 # if not (arr[j + 1] > arr[j]), do nothing
#				{  #					temp = arr[j];             // swap elements
sw  $t6,($t3) #					arr[j] = arr[j + 1];
sw  $t5,($t4) #					arr[j + 1] = a[j];
addi $s3,$0,1	#					flag = 1;               // indicates that a swap occurred.
#				}
#			}
noswapasc03:
j endasc3           # done what we need to do when asc ==0
else3:   #			else
addi $t4,$s4,1  #t4 = j+1  
sll  $t4,$t4,2  # t4 = (j+1)*4
add  $t4,$t4,$s0 #t4 = (j+1)*4 + base address of arr = address of arr[j+1]
addi $t3,$t4,-4  #t3 = (j)*4 + base address of arr = address of arr[j] #Thai Thien 1351040
lw   $t5,($t3)   #t5 = arr[i]
lw   $t6,($t4)   #t6 = arr[i+1]
slt $t0,$t6,$t5  #if (arr[j + 1] < arr[j])  then t0 = 1
beq $t0,$0,noswapasc03 # if not (arr[j + 1] < arr[j]), do nothing
#				{  #					temp = arr[j];             // swap elements
sw  $t6,($t3) #					arr[j] = arr[j + 1];
sw  $t5,($t4) #					arr[j + 1] = a[j];
addi $s3,$0,1	#	flag = 1;               // indicates that a swap occurred.	
endasc3:
addi $s4, $s4,1  #increase j
for3:
addi $t1,$s1,-1   # t1 = num-1
slt  $t0, $s4,$t1 # j < (num - 1) then t0 = 1
bne  $t0,$0,forLoop3
#	}
#}
while3:
bne $s3,$0,whileLoop3  # while (flag) , loop

donebubblesort3:

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
