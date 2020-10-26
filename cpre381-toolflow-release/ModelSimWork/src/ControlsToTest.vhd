library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;



entity ControlsToTest is

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
	
end ControlsToTest;

architecture ControlsToTest_arch of ControlsToTest is

      component ALUControler
            port(  
  
    opcode				 : in std_logic_vector(0 to 5);
	funct				 : in std_logic_vector(0 to 5);
	
    ALUControl           : out std_logic_vector(0 to 3);
	IsUnsigned           : out std_logic

            );
        end component;

        component Control
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
        end component;

    --end components

signal poo : std_logic_vector(0 to 5);


    begin


    ALUCon: ALUControler
        port map(
                opcode	        => opcode,
                funct	    	=> funct,
                ALUControl	    => ALUControl,
                IsUnsigned		=> IsUnsigned 
    );

    Con: Control
        port map(
                opcode	        => opcode,
                ALUControl	    => poo,
				ALUSrc	    	=> ALUSrc,
                MemtoReg	    => MemtoReg,
                s_DMemWr		=> s_DMemWr,
                s_RegWr	    	=> s_RegWr,
				s_Lui	    	=> s_Lui,
                RegDst	    	=> RegDst
    );






end ControlsToTest_arch;