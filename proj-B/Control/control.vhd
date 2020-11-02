library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity control is
  port(
     
    opcode				  : in std_logic_vector(0 to 5);
	jr					  : in std_logic;

    ALUControl            : out std_logic_vector(0 to 5);
    ALUSrc        		  : out std_logic;
    MemtoReg           	  : out std_logic;
    s_DMemWr              : out std_logic;
	s_RegWr               : out std_logic;
	s_Lui                 : out std_logic;
	o_Branch				  : out std_logic;
	RegDst                : out std_logic
	);
	
end control;

-- Notes on ALUop ctl signals
-- if it is a shift op ALUop(0) = 0
-- if it is a alu op ALUop(0) = 1
-- in order of ALUOp(1) to ALUOp(3)
--     sll 111
--     sla 110
--     srl 101
--     sra 100
-- for alu ops
--     and 111
--     or 110
--     xor 101
--     nand 100
--     nor 011
--     add 010
--     sub 001
--     slt 00


architecture controlArch of control is
begin

	-- still need     branch
	ALUControl <= opcode;
	
	-- 0 for R type BNE and BEQ
	ALUSrc <= '0' when (opcode = "000000" OR opcode = "000101" OR opcode = "000100") else
			  '1';
			  
	MemtoReg <= '1' when (opcode = "100011") else
			    '0';
			  
	s_DMemWr <= '1' when (opcode = "101011") else
			    '0';
	--0 for all branching and sw
	s_RegWr <= '0' when (opcode = "101011" OR opcode = "000101" OR opcode = "000100" OR opcode = "000011" or jr = '1') else
			    '1';
				
	RegDst <= '1' when (opcode = "000000") else
			    '0';
				
	s_Lui <= '1' when (opcode = "001111") else
			    '0';
	--Branching instructions except jr
	o_Branch	<= '1' when (opcode = "000010" OR opcode = "000101" OR opcode = "000100" OR opcode = "000011") else
			    '0';
			  
end controlArch;