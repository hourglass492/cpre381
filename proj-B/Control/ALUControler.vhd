	library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity ALUControler is
  port(
  
    opcode				  : in std_logic_vector(0 to 5);
	funct				  : in std_logic_vector(0 to 5);
	
    ALUControl           : out std_logic_vector(0 to 3);
	IsUnsigned               : out std_logic
	);
	
end ALUControler;

architecture ALUControl_arch of ALUControler is

begin

		ALUControl <= "1111" when ((funct = "100100" and opcode = "000000") OR opcode = "001100")else
					"1110" when ((funct = "100101" AND opcode = "000000") OR opcode = "001101")else
					"1101" when ((funct = "100110" AND opcode = "000000") OR opcode = "001110" )else
					"1100" when (opcode = "101011")else
					"1011" when (funct = "100111" AND opcode = "000000")else
					"1010" when (((funct = "100000" OR funct = "100001") AND opcode = "000000") OR (opcode = "001000" OR opcode = "001001"))else
					"1001" when ((funct = "100010" OR funct = "100011") AND opcode = "000000")else
					"1000" when (((funct = "101010" OR funct = "101011") AND opcode = "000000") OR (opcode = "001011" OR opcode = "001010"))else
					"0111" when ((funct = "000000" OR funct = "000100") AND opcode = "000000")else
					"0101" when ((funct = "000010" OR funct = "000110") AND opcode = "000000")else
					"0100" when ((funct = "000011" OR funct = "000111") AND opcode = "000000")else
					"0000";	

		IsUnsigned <= '1' when ( ((funct = "100001" OR funct = "100011" OR funct = "101011") AND (opcode = "000000")) OR (opcode = "001011" OR opcode = "001001")) else
			    '0';

end ALUControl_arch;