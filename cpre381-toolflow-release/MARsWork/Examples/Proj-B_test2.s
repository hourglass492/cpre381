.text

	addi $t1, $zero, 10
	addi $t2, $zero, 10
	addi $t3, $zero, 30

	beq	$t1, $t2, A
A:
	bne $t2, $t3, B
B:
	j C
C:
	jal D
D:
	jr $ra
E:
	li   $v0, 10
	syscall
