.data 
.space 64

.space 64
file: .asciiz "a.txt"
buffer: .space 1024 
##############


.text 
main:
#read from file
addi   $v0,$0, 14       # system call for read from file
la $a0, file     # file descriptor 
la   $a1, buffer   # address of buffer to which to read
addi   $a2,$0, 1024     # hardcoded buffer length
syscall            # read from file


addi   $v0,$0, 4       # system call for print
la $a0, buffer
syscall



addi $v0, $0, 10  
syscall
###########


#########################
#int linearsearch ( int * arr, int numofelements, int val ) int linearsearch ( int * arr, int numofelements, int val ) 
.text
linearsearch:
# $a0 int arr
# $a1 int numofelements
# $a2 int val

addi $t1, $a0,0	#t1 contain address of arr
addi $t7,$0,0	#$t7=0
addi $t3, $a2,0 #$t3 = num of element
addi $t4, $a3,0 #$t4 = val
addi $v0,$0,-1   #return value is -1
j begin11	#begin loop
loop11: addi $t7,$t7,1	#increase $t7 as counting number
begin11:
lw $t0,($t1)	#load num into $t0
addi $t1,$t1,4 	#increase pointer t1
beq $t7,$t3,break11	#break loop when end of arr
beq $t0,$t4,found1      #found num 
bne $t0,$0,loop11 #if not equal 0, jump to loop

found1:
addi $t1,$t1,-1  #decrease couting number
#addi $v0,$t

break11: 	
addi $v0, $t7,0	#v0 = t7, return t7
jr $ra  	#return
