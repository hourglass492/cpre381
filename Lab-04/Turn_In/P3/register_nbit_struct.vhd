library IEEE;
use IEEE.std_logic_1164.all;

entity register_nbit_struct is
  generic(N : integer := 31);
  
  port(
     
    
    i_CLK             : in std_logic;
    i_RST               : in std_logic;
    i_WE              : in std_logic;
    i_D               : in std_logic_vector(0 to N);   

    o_Q               : out std_logic_vector(0 to N)

	);
	
end register_nbit_struct;

architecture register_nbit_struct_arch of register_nbit_struct is

    component dff
        port(
            i_CLK        : in std_logic;     -- Clock input
            i_RST        : in std_logic;     -- Reset input
            i_WE         : in std_logic;     -- Write enable input
            i_D          : in std_logic;     -- Data value input
            
            o_Q          : out std_logic   -- Data value output
            );
    end component;

    begin



        
        G1: for i in 0 to N generate
            dff_i: dff 
                port map(
                    i_CLK      => i_CLK,
                    i_RST      => i_RST,
                    i_WE       => i_WE,
                    i_D        => i_D(i),

                    o_Q        => o_Q(i)

                        );

        end generate;



end register_nbit_struct_arch;