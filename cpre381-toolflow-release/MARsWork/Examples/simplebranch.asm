main:
	#j exit
	#ori $s0, $zero 0x1234
	#j skip
	#li $s0 0xffffffff
#skip:
	#ori $s1 $zero 0x4321
#	beq $s0 $s1 skip2
	#li $s0 0xffffffff
#skip2:
	jal fun
	#ori $s3 $zero 0x1234
	
	#bne $zero, $s0 exit
	#ori $s4 $zero 0x1234
	j exit

exit:
	li   $v0, 10          # system call for exit
      	syscall               # Exit!
		
fun:
	ori $s2 $zero 0x1234
	jr $ra