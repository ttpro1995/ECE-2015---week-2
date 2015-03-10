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
val:     .word  18



.text
main:
la $a0, aa1             #load arg arr
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



#####################
#int binarysearch ( int * arr, int numofelements, int val ) ;
#store saved register
binary_search:
addi $sp, $sp, -32   # decrease stack pointer by 32 byte all 8 register
sw $s0, 28($sp)    #store $s0
sw $s1, 24($sp)	#store $s1
sw $s2, 20($sp)#store $s2
sw $s3, 16($sp)#store $s3
sw $s4, 12($sp)#store $s4
sw $s5, 8($sp)#store $s5
sw $s6, 4($sp)#store $s6
sw $s7, 0($sp)#store $s7

add $s0,$a0,$0  #$s0 = base address of array
add $s1,$a1,$0  #$s1 = length
add $s2,$a2,$0  #$s2 = val

add $a0,$s0,$0  # $a0 = base address of array
addi $a1,$0,0   # $a1 = low = 0
add  $a2,$s1,$0 # $a2 = high = length of array
add  $a3,$s2,$0 # $a3 = x = val which is key

addi $sp,$sp,-4 #decrease stack pointer by 4
sw $ra,($sp)   #store $ra
jal binary_search_rercusion
# return value should be in $v0
lw $ra,($sp)  #restore $ra
addi $sp,$sp,4   #increase stack pointer by 4


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
####################





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
binary_search_rercusion:
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



#int bsearch_recursive(int a[], int low, int high, int x)

add   $s0,$a0,$0 #$s0 = base address of a[]
add   $s1,$a1,$0 #$s1 = low
add   $s2,$a2,$0 #$s2 = high
add   $s3,$a3,$0 #$s3 = x
addi  $s7,$0,-1  #s7 = return value
# $s5 = mid
# $s6 = address of a[mid]
# $s4 = a[mid]

#	if (high<low) return -1;
slt $t0,$s2,$s1    #if high < low, t0 = 1
bne $t0,$0,notfound3   #jump to notfound3 which will return -1


#	int mid = (low + high) / 2;
add $s5,$s1,$s2       # $s5 = mid = low + high
srl $s5,$s5,1         # $s5 =  (low + high) / 2;

add $s6,$s5,$s5       # $s6 = i*2
add $s6,$s6,$s6       # $s6 = i*4
add $s6,$s6,$s0       # $s6 = $s6 + base address of a[]
lw $s4,($s6)          # load a[mid] into s4

#	if (x < a[mid]) return bsearch_recursive(a, low, mid - 1, x);
slt $t0,$s3,$s4       # if ( x < a[mid]) $t0 = 1
bne $t0,$0,foundleft3  # jump to found left to recur left sub array

#		
#	else if (a[mid] < x) return bsearch_recursive(a, mid + 1, high, x);
slt $t0,$s4,$s3   #if (a[mid] < x)  $t0 = 1
bne $t0,$0,foundright3 # jump to found left to recur right sub array
		
#	else
j foundmid3          #		return mid;
#}


foundmid3: #return a[i]
add $s7,$s5,$0 # s7 = return value = mid 
j notfound3  #done setting v0

foundleft3: #recur left sub array
#return bsearch_recursive(a, low, mid - 1, x);
addi $sp,$sp,-4 #decrease stack pointer by 4
sw $ra,($sp)   #store $ra
addi $t1,$s5,-1  #t1 = mid-1
add $a2,$t1,$0   # arg $a2 = mid - 1
jal  binary_search_rercusion #recur call 
# $v0 = bsearch_recursive(a, low, mid - 1, x)
add $s7,$v0,$0     #set $s7 new return value
lw $ra,($sp)  #restore $ra
addi $sp,$sp,4   #increase stack pointer by 4
j notfound3   #done setting v0


foundright3:  #recur right sub array
#return bsearch_recursive(a, mid + 1, high, x)
addi $sp,$sp,-4 #decrease stack pointer by 4
sw $ra,($sp)   #store $ra
addi $t1,$s5,1  #t1 = mid-1
add $a1,$t1,$0   # arg $a1 = mid + 1
jal  binary_search_rercusion #recur call 
# $v0 = return bsearch_recursive(a, mid + 1, high, x)
add $s7,$v0,$0     #set $s7 new return value
lw $ra,($sp)  #restore $ra
addi $sp,$sp,4   #increase stack pointer by 4
j notfound3   #done setting v0


notfound3:   # return current s7
#do nothing
#keep $s7 as it was 


add $v0,$s7,$0   #set $v0 = $s7 

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
