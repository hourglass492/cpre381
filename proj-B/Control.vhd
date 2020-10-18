library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity Control is
  port(
     
    opcode				  : in std_logic_vector(0 to 5);

    ALUControl            : out std_logic_vector(0 to 5);
    ALUSrc        		  : out std_logic;
    MemtoReg           	  : out std_logic;
    s_DMemWr              : out std_logic;
	s_RegWr               : out std_logic;
	s_Lui                 : out std_logic;
	RegDst                : out std_logic
	);
	
end Control;

architecture ControlArch of Control is
begin
	ALUControl <= opcode;
	
	ALUSrc <= '0' when (opcode = "000000") else
			  '1';
			  
	MemtoReg <= '1' when (opcode = "100011") else
			    '0';
			  
	s_DMemWr <= '1' when (opcode = "101011") else
			    '0';
				
	s_RegWr <= '0' when (opcode = "101011") else
			    '1';
				
	RegDst <= '1' when (opcode = "000000") else
			    '0';
				
	s_Lui <= '1' when (opcode = "001111") else
			    '0';
			  
end ControlArch;