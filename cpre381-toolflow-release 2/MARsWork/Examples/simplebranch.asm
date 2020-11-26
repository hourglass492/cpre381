main:


	addi $s3 $zero 0xBBBB
	andi $s3 $zero 0xBBBB
	ori $s0 $zero 0xBBBB
	
	bne $s0, $zero A
	
	
	ori $s0 $zero 0xBEEF



A:

	addi $s0 $zero 0x0000

	beq $s0, $zero B
	
	
	ori $s0 $zero 0xBEEF



B:




	jal fun

	addi $s4 $zero 0xFFFF
	andi $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF

	jal notfun

	addi $s4 $zero 0xFFFF
	andi $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF

	jal ehhfun

	addi $s4 $zero 0xFFFF
	andi $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF



	j exit
fun:
	addi $s2 $zero 0xAAAA
	andi $s2 $zero 0xAAAA
	ori $s2 $zero 0xAAAA

	jr $ra
	
notfun:
	addi $s2 $zero 0x0BAD
	andi $s2 $zero 0x0BAD
	ori $s2 $zero 0x0BAD

	jr $ra
	
	
ehhfun:
	addi $s2 $zero 0xEEEA
	andi $s2 $zero 0xEEEA
	ori $s2 $zero 0xEEEA

	jr $ra
	
	
	
	
exit:
	li   $v0, 10          # system call for exit
	
      	syscall               # Exit!
		
