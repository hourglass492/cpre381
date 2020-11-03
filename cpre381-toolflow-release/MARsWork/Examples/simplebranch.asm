main:


	addi $s3 $zero 0xBBBB

	jal fun
	
	#bne $zero, $s0 exit
	addi $s4 $zero 0xFFFF



	j exit
fun:
	addi $s2 $zero 0xAAAA

	jr $ra
exit:
	li   $v0, 10          # system call for exit
	
      	syscall               # Exit!
		
