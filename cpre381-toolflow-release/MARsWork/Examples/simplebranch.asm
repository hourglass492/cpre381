main:


	addi $s3 $zero 0x0BBB

	jal fun
	
	#bne $zero, $s0 exit
	addi $s4 $zero 0x0FFF



	j exit
fun:
	addi $s2 $zero 0x0AAA

	jr $ra
exit:
	li   $v0, 10          # system call for exit
	
      	syscall               # Exit!
		
