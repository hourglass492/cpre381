.text

	addi $t1, $zero, 10
	addi $t2, $zero, 10
	addi $t3, $zero, 30

	beq	$t1, $t2, A
	addi $t1, $zero, 10
A:
	bne $t2, $t3, B
	addi $t1, $zero, 10
B:
	j C
	addi $t1, $zero, 10
C:
	jal D
	
	
	li   $v0, 10
	syscall
	
D:
	addi $t1, $zero, 15
	jr $ra
E:

