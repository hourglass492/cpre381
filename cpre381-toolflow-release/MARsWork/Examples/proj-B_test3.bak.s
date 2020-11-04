.data
array:	.word   0 : 7						 #declare array
N:	.word  7						 		 #declare size N
comma:	.asciiz  ", "          			 	 #comma to insert between numbers
message: .asciiz  "The Sorted array is:\n"	 #declare message

.text
	la $s0, array
	la $s5, N			#s5 gets size
	lw $s5, 0($s5)		#load value of size
      
	#load the array with values
	addi $t1, $zero, 101
	sw $t1, 0($s0)
	lw $t1, 0($s0)
	
	addi $t1, $zero, 9
	sw $t1, 4($s0)
	lw $t1, 4($s0)
	
	
	addi $t1, $zero, 3
	sw $t1, 8($s0)
	lw $t1, 8($s0)
	
	addi $t1, $zero, 113
	sw $t1, 12($s0)
	lw $t1, 12($s0)
	
	addi $t1, $zero, 13
	sw $t1, 16($s0)
	lw $t1, 16($s0)
	
	addi $t1, $zero, 6
	sw $t1, 20($s0)
	lw $t1, 20($s0)
	
	addi $t1, $zero, 19
	sw $t1, 24($s0)
	lw $t1, 24($s0)
	
	addi $t1, $zero, 27
	sw $t1, 28($s0)
	lw $t1, 28($s0)
	
	addi $t1, $zero, 167
	sw $t1, 32($s0)
	lw $t1, 32($s0)
	
	addi $t1, $zero, 199
	sw $t1, 36($s0)
	lw $t1, 36($s0)
	
	addi $t1, $zero, 90
	sw $t1, 40($s0)
	lw $t1, 40($s0)
	
	addi $t1, $zero, 55
	sw $t1, 44($s0)
	lw $t1, 44($s0)
	
	addi $t1, $zero, 45
	sw $t1, 48($s0)
	lw $t1, 48($s0)
	
	addi $t1, $zero, 180
	sw $t1, 52($s0)
	lw $t1, 52($s0)
	
	addi $t1, $zero, 1
	sw $t1, 56($s0)
	lw $t1, 56($s0)
	

      	
	
	addi $sp, $sp, 100 	#move the stack pointer 
	sw $s0, 0($sp)		#store the pointer to the head of array
	sw $s5, 4($sp)		#store the sive of the array
	
	
	add $a0, $zero, $s0	#move head pointer to $a0
	add $a1, $zero, $s5	#move n to $a1

	jal bubblesort		#jump and link to bubblesort algorithm


	la   $a0, array			#load pointer to array to $a0
	add  $a1, $s5, $zero	#increment to next element of array
	jal  print				#print
	li   $v0, 10
	syscall					#exit program


bubblesort:
	beq $a1, 1, endsort		# if N = 1, done
	add $s1, $zero, $zero	#i = 0
	add $t0, $zero, $zero
	addi $s2, $a1, -1		#$s2 = N-1
	
while:
	slt $t0, $s1, $s2		#i < N-1
	bne $t0, 1, endwhile	#if i < N-1continue. else branch to done
	
	#$t1 = i*4
	add $t1, $s1, $s1
	add $t1, $t1, $t1
	add $t1, $a0, $t1

	lw $t2, 0($t1)		#load t1 with arr[i]
	
	addi $t3, $s1, 1	#i+1
	add $t3, $t3, $t3	#(i+1)*2
	add $t3, $t3, $t3	#(i+1)*4
	add $t3, $s0, $t3	#increment
	lw $t4, 0($t3)		#load value from new addresss
      	
	add $t0, $zero, $zero	#reset $t0 = 0
	slt $t0, $t4, $t2		#arr[i+1] < arr[i]
	bne $t0, 1, noswap		#if slt fails, jump to noswap ebcause the elements are in the correct order
	sw $t2, 0($t3)			#swap i and i+1
	sw $t4, 0($t1)			#swap i+1 and i
noswap:
	addi $s1, $s1, 1		#increment j
	j while					#jump back to the while loop
	
endwhile:
	addi $sp, $sp, -12		#move stack pointer
	sw $a0 0($sp)				
	sw $a1 4($sp)				
	sw $ra 8($sp)				

	addi $a1, $a1, -1	#decrement the size of the array	

	jal bubblesort     	#jump back to bubblesort

	lw $a0, 0($sp)		#load values and reset stack pointer	
	lw $a1, 4($sp)			
	lw $ra, 8($sp)			
	addi $sp, $sp, 12		

endsort:
	jr $ra

print:
	add  $s0, $zero, $a0		#load array head address
	add  $t1, $zero, $a1		#load size of array N
	la   $a0, message			#load address of meaasge
	li   $v0, 4		
	syscall						#print message
printloop:
	lw   $a0, 0($s0)			#load number from memory
	li   $v0, 1		
	syscall						# print number
	la   $a0, comma				#load address comma
	li   $v0, 4		
	syscall						#print comma
	addi $s0, $s0, 4			#increment iterator
	addi $t1, $t1, -1			#decrement N
	bne $t1, $zero, printloop	#loop until all elements are printed
	jr   $ra