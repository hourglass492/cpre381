main:
	ori $s0, $zero 0x1234
	
	

	#j skip
	#li $s0 0xffffffff
#skip:
	#ori $s1 $zero 0x4321
#	beq $s0 $s1 skip2
	#li $s0 0xffffffff
#skip2:

	ori $s3 $zero 0xBBBB
	ori $s3 $zero 0xBBBB
	ori $s3 $zero 0xBBBB
	ori $s3 $zero 0xBBBB
	jal fun
	
	#bne $zero, $s0 exit
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF
	ori $s4 $zero 0xFFFF

	j exit
fun:
	ori $s2 $zero 0x1234
	ori $s2 $zero 0x1234
	ori $s2 $zero 0x1234
	ori $s2 $zero 0x1234
	ori $s2 $zero 0x1234
	jr $ra
exit:
	li   $v0, 10          # system call for exit
	ori $s0, $s0, 0
      	syscall               # Exit!
		
