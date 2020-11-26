# Compute several Fibonacci numbers and put in array, then print
.data
fibs:.word   0 : 3         # "array" of words to contain fib values
size: .word  3             # size of "array" (agrees with array declaration)
prompt: .asciiz "How many Fibonacci numbers to generate? (2 <= x <= 19)"
.text
      la   $s0, fibs        # load address of array
      addi $s0, $s0, 0      #Check value
      la   $s5, size        # load address of size variable
      addi $s5, $s5, 0      #Check value
      lw   $s5, 0($s5)      # load array size
      addi $s5, $s5, 0      #Check Value

# Optional: user inputs the number of Fibonacci numbers to generate
#pr:   la   $a0, prompt      # load address of prompt for syscall
#      li   $v0, 4           # specify Print String service
#      syscall               # print the prompt string
#      li   $v0, ?????Replace_this_dummy_with_the_correct_numeric_value???????           # specify Read Integer service
#      syscall               # Read the number. After this instruction, the number read is in $v0.
#      bgt  $v0, $s5, pr     # Check boundary on user input -- if invalid, restart
#      blt  $v0, $zero, pr   # Check boundary on user input -- if invalid, restart
#      add  $s5, $v0, $zero  # transfer the number to the desired register
      
      
      li   $s2, 1           # 1 is the known value of first and second Fib. number
      addi $s2, $s2, 0      #Check Value
      sw   $s2, 0($s0)      # F[0] = 1
      sw   $s2, 4($s0)      # F[1] = F[0] = 1
      addi $s1, $s5, -2     # Counter for loop, will execute (size-2) times
      addi $s5, $s5, 0      #check Value


      # Loop to compute each Fibonacci number using the previous two Fib. numbers.
loop: lw   $s3, 0($s0)      # Get value from array F[n-2]
      addi $s3, $s3, 0      #Check Value
      lw   $s4, 4($s0)      # Get value from array F[n-1]
      addi $s4, $s4, 0      #Check Value
      add  $s2, $s3, $s4    # F[n] = F[n-1] + F[n-2]
      addi $s2, $s2, 0      # Check Value
      sw   $s2, 8($s0)      # Store newly computed F[n] in array
      addi $s0, $s0, 4      # increment address to now-known Fib. number storage
      addi $s0, $s0, 0        # Check Value
      addi $s1, $s1, -1     # decrement loop counter
      addi $s1, $s1, 0        # Check Value
      bne $s1, $zero, loop  # repeat while not finished
      
      # Fibonacci numbers are computed and stored in array. Print them.
      la   $a0, fibs        # first argument for print (array)
      addi $a0, $a0, 0      #Check value
      add  $a1, $zero, $s5  # second argument for print (size)
      addi $a1, $a1, 0      # Check Value
      jal  print            # call print routine. 

      # The program is finished. Exit.
      
      li   $v0, 10          # system call for exit
      addi $v0, $v0, 0      #Check Value
      syscall               # Exit!
      j die 
		
###############################################################
# Subroutine to print the numbers on one line.
      .data
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "The Fibonacci numbers are:\n"
      .text
print: addi $ra, $ra, 0
      add  $t0, $zero, $a0  # starting address of array of data to be printed
      addi $t0, $t0, 0      # Check Value
      add  $t1, $zero, $a1  # initialize loop counter to array size
      addi $t1, $t1, 0      # Check Value
      la   $a0, head        # load address of the print heading string
      addi $a0, $a0, 0      #Check value
      ori  $v0, $zero , 4           # specify Print String service
      addi $v0, $v0, 0      # Check Value
      syscall               # print the heading string
      
out:  addi $ra, $ra, 0
      lw   $a0, 0($t0)      # load the integer to be printed (the current Fib. number)
      addi $a0, $a0, 0      #Check Value
      ori  $v0, $zero , 1           # specify Print Integer service
      addi $v0, $v0, 0      # Check Value
      syscall               # print fibonacci number
      
      la   $a0, space       # load address of spacer for syscall
      addi $a0, $a0, 0      #Check value
      ori  $v0, $zero , 4           # specify Print String service
      addi $v0, $v0, 0      # Check Value
      syscall               # print the spacer string
      
      addi $t0, $t0, 4      # increment address of data to be printed
      addi $t1, $t1, -1     # decrement loop counter
      bne $t1, $zero , out         # repeat while not finished
      
      jr   $ra              # return from subroutine
      
die:
# End of subroutine to print the numbers on one line
###############################################################
