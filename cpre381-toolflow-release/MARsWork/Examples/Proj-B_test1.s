.data
array:	.word   0 : 15

.text
	#la $s0, array

	addi $t1, $zero, 10
	addi $t2, $zero, 200
	add $t3, $t1, $t2
	#addiu $t3, $zero, 30
	#addu $t3, $t1, $t2
	#and $t3, $t1, $t2
	#andi $t3, $zero, 30
	#lui $t3, 30
	#sw $t1, 0($s0)
	#lw $t1, 0($s0)
	#nor $t3, $t1, $t2
	#xor $t3, $t1, $t2
	#xori $t3, $zero, 100
	#or $t3, $t1, $t2
	#ori  $t3, $zero, 100
	slt $t3, $t2, $t1
	slt $t3, $t1, $t2
	
	slti $t3, $t1, 50
	slti $t3, $t2, 50
	
	sltiu $t3, $t1, 50
	sltiu $t3, $t2, 50
	
	sltu $t3, $t1, $t2
	sltu $t3, $t2, $t1
	
	#sll $t3, $t1, 4
	#srl $t3, $t1, 4
	#sra $t3, $t1, 4
	#sllv $t3, $t1, $t1
	#srlv $t3, $t1, $t1
	#srav $t3, $t1, $t1
	#sub $t3, $t1, $t1
	#subu $t3, $t1, $t1
	
	li   $v0, 10
	syscall
