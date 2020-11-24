library IEEE;
use IEEE.std_logic_1164.all;


entity ID_EX is
  
  port(
     
    
    i_CLK             			: in std_logic;
    i_stall              		: in std_logic;
    i_if_flush              	: in std_logic;
    i_RS             			: in std_logic_vector(0 to 31);   
    i_RT         			 	: in std_logic_vector(0 to 31);   
	i_MemtoReg					: in std_logic;
	i_RegWrite					: in std_logic;
	i_MemWrite					: in std_logic;
	i_MemRead					: in std_logic;
	i_ALUSrc					: in std_logic;
	i_RegDst					: in std_logic;
	i_AluOp						: in std_logic_vector(0 to 3);
	i_ExtendedImmediate			: in std_logic_vector(0 to 31);
	i_RdAddress					: in std_logic_vector(0 to 4);
	i_RtAddress					: in std_logic_vector(0 to 4);
	i_RsAddress					: in std_logic_vector(0 to 4);

    o_RT               			: out std_logic_vector(0 to 31);
	o_RS		 	  			: out std_logic_vector(0 to 31);
	o_MemtoReg					: out std_logic;
	o_RegWrite					: out std_logic;
	o_MemWrite					: out std_logic;
	o_MemRead					: out std_logic;
	o_ALUSrc					: out std_logic;
	o_RegDst					: out std_logic;
	o_AluOp						: out std_logic_vector(0 to 3);
	o_ExtendedImmediate			: out std_logic_vector(0 to 31);
	o_RdAddress					: out std_logic_vector(0 to 4);
	o_RtAddress					: out std_logic_vector(0 to 4);
	o_RsAddress					: out std_logic_vector(0 to 4)

	);
	
end ID_EX;

architecture ID_EX_arch of ID_EX is

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
	Signal s_Def5, s_RdAddress, s_RtAddress, s_RsAddress, s_Stall5  : std_logic_vector(0 to 4);
	Signal s_ExtendedImmediate, s_RT, s_RS, s_Stall, s_Default  : std_logic_vector(0 to 31);
	
	
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

        
        
            RS: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RS,
                    i_Default    => s_Default,

                    o_Q        => s_RS

                        );
						
			RT: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RT,
                    i_Default    => s_Default,

                    o_Q        => s_RT

                        );
						
			Immediate: register_nbit_struct 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_ExtendedImmediate,
                    i_Default    => s_Default,

                    o_Q        => s_ExtendedImmediate

                        );
			
			RdAddress: register_nbit_struct 
			generic map (N => 4)
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RdAddress,
                    i_Default    => s_Def5,

                    o_Q        => s_RdAddress

                        );	
						
			RtAddress: register_nbit_struct 
			generic map (N => 4)
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RtAddress,
                    i_Default    => s_Def5,

                    o_Q        => s_RtAddress

                        );	

			RsAddress: register_nbit_struct 
			generic map (N => 4)
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RsAddress,
                    i_Default    => s_Def5,

                    o_Q        => s_RsAddress

                        );	

			ALUOP: register_nbit_struct 
			generic map (N => 3)
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_AluOp,
                    i_Default    => s_Def4,

                    o_Q        => s_AluOp

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

			MemWrite: dffg 
	
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_MemWrite,
                    i_Default    => s_Def,

                    o_Q        => s_MemWrite

                        );	
						
			MemRead: dffg 
			
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_MemRead,
                    i_Default    => s_Def,

                    o_Q        => s_MemRead

                        );	

			ALUSrc: dffg 
			
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_ALUSrc,
                    i_Default    => s_Def,

                    o_Q        => s_ALUSrc

                        );	
						
			RegDst: dffg 
			
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => RegReset,
                    i_WE       => RegWrite,
                    i_D        => i_RegDst,
                    i_Default    => s_Def,

                    o_Q        => s_RegDst

                        );	
						
			o_RT <= s_Stall and s_RT;
			o_RS <= s_Stall and s_RS;
			o_ExtendedImmediate <= s_Stall and s_ExtendedImmediate;
			o_RdAddress <= s_Stall5 and s_RdAddress;
			o_RsAddress <= s_Stall5 and s_RsAddress;
			o_RtAddress <= s_Stall5 and s_RtAddress;
			o_AluOp <= s_Stall4 and s_AluOp;
			
			o_MemtoReg <= s_Stall1 and s_MemtoReg;
			o_RegWrite <= s_Stall1 and s_RegWrite;
			o_MemWrite <= s_Stall1 and s_MemWrite;
			o_MemRead <= s_Stall1 and s_MemRead;
			o_ALUSrc <= s_Stall1 and s_ALUSrc;
			o_RegDst <= s_Stall1 and s_RegDst;
		
			 


end ID_EX_arch;