.data
array:	.word   0 : 15

.text

	lui $1, 4097

	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0

	addi $0, $0, 0
	ori $16, $1,0


	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0

	addi $t1, $zero, 10
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $t2, $zero, 200
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	add $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addiu $t3, $zero, 30
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addu $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	and $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	andi $t3, $zero, 30
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	lui $t3, 30
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	sw $t1, 0($s0)
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	lw $t1, 0($s0)
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	nor $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	xor $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	xori $t3, $zero, 100
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	or $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	ori  $t3, $zero, 100
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	slt $t3, $t2, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	slt $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	
	slti $t3, $t1, 50
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	slti $t3, $t2, 50
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	
	sltiu $t3, $t1, 50
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	sltiu $t3, $t2, 50
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	
	sltu $t3, $t1, $t2
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	sltu $t3, $t2, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	
	sll $t3, $t1, 4
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	srl $t3, $t1, 4
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	sra $t3, $t1, 4
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	sllv $t3, $t1, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	srlv $t3, $t1, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	srav $t3, $t1, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	sub $t3, $t1, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	subu $t3, $t1, $t1
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	
	li   $v0, 10
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	addi $0, $0, 0
	syscall
