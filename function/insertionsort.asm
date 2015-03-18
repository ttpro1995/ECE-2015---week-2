#Thai Thien

.data
aa1:	.word	1
aa2:	.word	3
aa3:	.word	2
#aa4:	.word	15
#aa5:	.word	12
#aa6:	.word	25
#aa7:	.word	17
#aa8:	.word	16
#aa9:	.word	18
#aa10:	.word	20
length:  .word  3
val:     .word  15

asc: .word 1


.text
main:
la $a0, aa1                 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
la $s2, asc		#load address asc into s2
lw $a2, ($s2)		#load arg asc
jal insertionSort	#call insertion search 

la $a0,aa1 		 #load arg arr
la $s1, length  	#load address length into s1
lw $a1, ($s1)		#load arg length
jal printArray          #print out sorted array

addi $v0,$0,10		#v0 = 10 exit
syscall			#exit

############################
insertionSort:
#void insertionSort(int arr[], int numofelement, int asc)
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

addi $s4,$0,1  #init $s4 = 1 = i


#s4 = i
#s5 = current
#s6 = j


For4: #for (int i=1;i<=numofelement-1;i++) {
# if not(numofelement-1 < i) then loop
addi $t1, $s1,-1 #t1 = num of element -1
slt $t0, $t1,$s4  #if not(numofelement-1 < i) then $t0 = 0
bne $t0,$0,doneFor4	#t0 not 0 then end Forloop

#current = arr[i]
sll $t2,$s4,2   # $t2 = 4*i
add $t2,$t2,$s0 #t2 = address of arr[i]
lw $t3,($t2)  # t3 = arr[i]	
add $s5,$t3,$0	#$s5 = current = arr[i];

addi $s6,$s4,-1	#int j = i - 1;

Insertasc4:
beq $s2,$0,Insertnotasc4 # asc = 0 branch Insertnotasc4    # if (asc)	
	
j conditionwhile41 #jump to condition
while41: #while (j >= 0 && current < arr[j]) 

				#{
#arr[j + 1] = arr[j];
sll $t2,$s6,2         #t2 = 4*j
add $t2,$s0,$0        #t2 = address arr[j]
addi $t3,$t2,4        #t3 = address arr[j+1]
lw $t4,($t2)          #t4 = arr[i]
sw $t4,($t3)          # arr[j+1] = arr[j]

addi $s6,$s6,-1		#		--j;
			#}

conditionwhile41:
slt $t0,$s6,$0    # not (j < 0) then  t0 = 0 (t0 = 1 fail while condition)
bne $t0,$0, failconditionwhile41 # t0 not 0 then fail while41 condition
sll $t2,$s6,2         #t2 = 4*j
add $t2,$t2,$s0        #t2 = address arr[j]
lw $t3,($t2)          #t3 = arr[j]
slt $t0,$s5,$t3       # if current < arr[j] then t0 =1
beq $t0,$0,failconditionwhile41  #t0 = 0 fail 
j while41  #while loop
failconditionwhile41:
						
j doneasc4      #skip not asc

Insertnotasc4:#				else
j conditionwhile42 #jump to condition
	while42: #while (j >= 0 && current > arr[j]) 
				#{
				#arr[j + 1] = arr[j];
sll $t2,$s6,2         #t2 = 4*j
add $t2,$s0,$0        #t2 = address arr[j]
addi $t3,$t2,4        #t3 = address arr[j+1]
lw $t4,($t2)          #t4 = arr[i]
sw $t4,($t3)          # arr[j+1] = arr[j]
addi $s6,$s6,-1		#		--j;
			#}
conditionwhile42:
slt $t0,$s6,$0    # not (j < 0) then  t0 = 0 (t0 = 1 fail while condition)
bne $t0,$0, failconditionwhile42 # t0 not 0 then fail while41 condition
sll $t2,$s6,2         #t2 = 4*j
add $t2,$t2,$s0        #t2 = address arr[j]
lw $t3,($t2)          #t3 = arr[j]
slt $t0,$t3,$s5       # if current > arr[j] then t0 =1
beq $t0,$0,failconditionwhile42  #t0 = 0 fail 
j while42  #while loop
failconditionwhile42:
		
doneasc4:		

# arr[j + 1] = current;
sll $t2,$s6,2         #t2 = 4*j
add $t2,$s0,$0        #t2 = address arr[j]
addi $t2,$t2,4        #t2 = address arr[j+1]
sw $s5,($t2)         # arr[j+1]= current

	#}



addi $s4,$s4,1  #increase i
j For4 #jump to condition

doneFor4:  #done for loop


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
