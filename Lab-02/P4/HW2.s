#The conditional code

j Condition


Loop: addi $s3,$s3,1 # i = i + 1

Condition: sll $t1,$s3,2 # Temp reg $t1 = i * 4

add $t1,$t1,$s6 # $t1 = address of save[i]

lw $t0,0($t1) # Temp reg $t0 = save[i]

beq $t0,$s5, Loop   # go to Exit if save[i] !≠ k or exit the loop if it is not equal

Exit: