library IEEE;
use IEEE.std_logic_1164.all;


entity IF_ID is
  generic(N : integer := 31);
  
  port(
     
    
    i_CLK             		  : in std_logic;
    i_stall              	  : in std_logic;
    i_if_flush                : in std_logic;
    i_instruction             : in std_logic_vector(0 to N);   
    i_pc         			  : in std_logic_vector(0 to N);   

    o_pc              		  : out std_logic_vector(0 to N);
	o_instruction	  		  : out std_logic_vector(0 to N)

	);
	
end IF_ID;

architecture IF_ID_arch of IF_ID is

    component register_nbit_struct
      port(
     
    
			i_CLK             : in std_logic;
			i_RST             : in std_logic;
			i_WE              : in std_logic;
			i_D               : in std_logic_vector(0 to N);   
			i_Default         : in std_logic_vector(0 to N);   

			o_Q               : out std_logic_vector(0 to N)

	);
    end component;

    
	
	Signal RegWrite, RegReset	: std_logic;
	Signal s_PC, s_instruction, s_Stall, s_Default  : std_logic_vector(0 to N);
	
	
	begin
	RegWrite <= not i_stall;
	RegReset <= i_if_flush;
	
	s_Default <= x"00000000";
	g1: for i in 0 to N generate
		s_Stall(i) <= RegWrite;
	end generate;

        
        
            Instruction: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_instruction,
                    i_Default    => s_Default,

                    o_Q        => s_instruction

                        );
						
			PC: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_pc,
                    i_Default    => s_Default,

                    o_Q        => s_PC

                        );
						
						
			o_pc <= s_Stall and s_PC;
			o_instruction <= s_Stall and s_instruction;


end IF_ID_arch;