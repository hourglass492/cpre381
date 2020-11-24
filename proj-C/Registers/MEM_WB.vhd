library IEEE;
use IEEE.std_logic_1164.all;


entity MEM_WB is
  generic(N : integer := 31);
  
  port(
     
    
    i_CLK             			: in std_logic;
    i_stall              		: in std_logic;
    i_if_flush              	: in std_logic;
	
    i_ALUOut             			: in std_logic_vector(0 to 31);   
    i_MemOut         			 	: in std_logic_vector(0 to 31);   
	i_MemtoReg					: in std_logic;
	i_RegWrite					: in std_logic;
	i_WriteAdress				: in std_logic_vector(0 to 4);

    o_MemOut                			: out std_logic_vector(0 to 31);
	o_ALUOut		 	  			: out std_logic_vector(0 to 31);
	o_MemtoReg					: out std_logic;
	o_RegWrite					: out std_logic;
	o_WriteAdress					: out std_logic_vector(0 to 4)

	);
	
end MEM_WB;

architecture MEM_WB_arch of MEM_WB is

    component register_nbit_struct
	generic(N : integer := 31);
      port(
     
    
			i_CLK             : in std_logic;
			i_RST             : in std_logic;
			i_WE              : in std_logic;
			i_D               : in std_logic_vector(0 to N);   
			i_Default         : in std_logic_vector(0 to N);   

			o_Q               : out std_logic_vector(0 to N)

	);
    end component;
	
	component dffg
        port(
            i_CLK        : in std_logic;     -- Clock input
            i_RST        : in std_logic;     -- Reset input
            i_WE         : in std_logic;     -- Write enable input
            i_D          : in std_logic;     -- Data value input
            i_Default          : in std_logic;     -- Data value input
			
            
            o_Q          : out std_logic   -- Data value output
            );
    end component;

    
	
	Signal RegWrite, RegReset, s_Def, s_MemtoReg, s_RegWrite, s_MemWrite, s_MemRead, s_ALUSrc, s_RegDst, s_Stall1	: std_logic;
	Signal s_Def4, s_AluOp, s_Stall4  : std_logic_vector(0 to 3);
	Signal s_Def5, s_WriteAdress, s_RtAddress, s_RsAddress, s_Stall5  : std_logic_vector(0 to 4);
	Signal s_ExtendedImmediate, s_ALUOut, s_MemOut, s_Stall, s_Default  : std_logic_vector(0 to 31);
	
	
	begin
	RegWrite <= not i_stall;
	RegReset <= i_if_flush;
	
	s_Default <= x"00000000";
	s_Def <= '0';
	s_Def4 <= "0000";
	s_Def5 <= "00000";
	
	
	g1: for i in 0 to 31 generate
		s_Stall(i) <= RegWrite;
	end generate;

	g2: for i in 0 to 3 generate
		s_Stall4(i) <= RegWrite;
	end generate;

	g3: for i in 0 to 4 generate
		s_Stall5(i) <= RegWrite;
	end generate;
	
	s_Stall1 <= RegWrite;

        
        
            ALUOut: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_ALUOut,
                    i_Default    => s_Default,

                    o_Q        => s_ALUOut

                        );
						
			MemOut: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_MemOut,
                    i_Default    => s_Default,

                    o_Q        => s_MemOut

                        );
						
			
			WriteAdress: register_nbit_struct 
			generic map (N => 4)
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_WriteAdress,
                    i_Default    => s_Def5,

                    o_Q        => s_WriteAdress

                        );	
	

	

			MemtoReg: dffg 
	
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_MemtoReg,
                    i_Default    => s_Def,

                    o_Q        => s_MemtoReg

                        );	

			t_RegWrite: dffg 
		
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RegWrite,
                    i_Default    => s_Def,

                    o_Q        => s_RegWrite

                        );			




                  
						
			o_MemOut <= s_Stall and s_MemOut;
			o_ALUOut <= s_Stall and s_ALUOut;
			o_WriteAdress <= s_Stall5 and s_WriteAdress;

			
			o_MemtoReg <= s_Stall1 and s_MemtoReg;
			o_RegWrite <= s_Stall1 and s_RegWrite;


		
			 


end MEM_WB_arch;