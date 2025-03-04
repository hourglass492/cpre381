library IEEE;
use IEEE.std_logic_1164.all;

entity mux_nbit_struct is
  generic(N : integer := 31);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select        : in std_logic;
    o_z             : out std_logic_vector(0 to N)

	);
	
end mux_nbit_struct;

architecture mux_nbit_struct_arch of mux_nbit_struct is

    component mux
        port(
            i_a             : in std_logic;
            i_b             : in std_logic;
            i_select        : in std_logic;
            o_z             : out std_logic
            );
    end component;

    begin

        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N generate
            mux_i: mux 
                port map(
                    i_a       => i_a(i),
                    i_b       => i_b(i),
                    i_select  => i_select,
                    o_z       => o_z(i)
                        );
        end generate;

  
end mux_nbit_struct_arch;