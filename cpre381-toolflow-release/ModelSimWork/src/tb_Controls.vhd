library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Controls is

end tb_Controls;

architecture behavior of tb_Controls is


  component ControlsToTest
    port(  
    opcode				  : in std_logic_vector(0 to 5);
	funct				  : in std_logic_vector(0 to 5);
	

	IsUnsigned            : out std_logic;
	ALUControl            : out std_logic_vector(0 to 3);
    ALUSrc        		  : out std_logic;
    MemtoReg           	  : out std_logic;
    s_DMemWr              : out std_logic;
	s_RegWr               : out std_logic;
	RegDst                : out std_logic;
	s_Lui                 : out std_logic

    );
  end component;

    -- Temporary signals to connect to the micro_processor2 component.
  signal opcode_s, funct_s : std_logic_vector(0 to 5);

  signal unsigned_s : std_logic;
  signal ctl :  std_logic_vector(0 to 3);
  signal ALUSrc_s, MemtoReg_s, Dmemwr_s, Regwr_s, RegDst_s, Lui_s  : std_logic;

begin

  thing_im_testing: ControlsToTest 
  port map(
        
            opcode       		=> opcode_s,
            funct       		=> funct_s,
			
			IsUnsigned  		=> unsigned_s,
            ALUControl          => ctl,
            ALUSrc              => ALUSrc_s,
            MemtoReg            => MemtoReg_s,
            s_DMemWr       		=> Dmemwr_s,
            s_RegWr             => Regwr_s,
            RegDst              => RegDst_s,
			s_Lui				=> Lui_s);


  
  -- Testbench process  
  -- Expected outputs in spreadsheet
  process
  begin


	
	funct_s <= "000000";
--------------------- I-type begin-----------------	
-- addi
    opcode_s <= "001000";
    wait for 100 ns;

-- addiu
    opcode_s <= "001001";
    wait for 100 ns;
	
-- andi
    opcode_s <= "001100";
    wait for 100 ns;

-- lui
    opcode_s <= "001111";
    wait for 100 ns;

-- xori
    opcode_s <= "001110";
    wait for 100 ns;
	
-- ori
    opcode_s <= "001101";
    wait for 100 ns;
	
-- slti
    opcode_s <= "001010";
    wait for 100 ns;
	
-- sltiu
    opcode_s <= "001011";
    wait for 100 ns;
	
--------------------- R-type begin-----------------
	opcode_s <= "000000";
	
-- add
    funct_s <= "100000";
    wait for 100 ns;	
	
-- addu
    funct_s <= "100001";
    wait for 100 ns;		
		
-- sub
    funct_s <= "100010";
    wait for 100 ns;
		
-- subu
    funct_s <= "100011";
    wait for 100 ns;
		
-- nor
    funct_s <= "100111";
    wait for 100 ns;
			
-- xor
    funct_s <= "100110";
    wait for 100 ns;
			
-- or
    funct_s <= "100101";
    wait for 100 ns;
			
-- and
    funct_s <= "100100";
    wait for 100 ns;
			
-- slt
    funct_s <= "101010";
    wait for 100 ns;
				
-- sltu
    funct_s <= "101011";
    wait for 100 ns;
				
-- sll
    funct_s <= "000000";
    wait for 100 ns;
				
-- srl
    funct_s <= "000010";
    wait for 100 ns;
				
-- sra
    funct_s <= "000011";
    wait for 100 ns;
					
-- sllv
    funct_s <= "000100";
    wait for 100 ns;
					
-- srlv
    funct_s <= "000110";
    wait for 100 ns;
					
-- srav
    funct_s <= "000111";
    wait for 100 ns;
	
	funct_s <= "000000";
	
------------------loading and storing------------------
-- lw
    opcode_s <= "100011";
    wait for 100 ns;	
	
-- sw
    opcode_s <= "101011";
    wait for 100 ns;	
end process;

end behavior;