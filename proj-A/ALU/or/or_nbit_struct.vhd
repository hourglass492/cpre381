library IEEE;
use IEEE.std_logic_1164.all;

entity xor_nbit_struct is
  generic(N : integer := 31);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    o_z             : out std_logic_vector(0 to N)

	);
	
end xor_nbit_struct;

architecture xor_nbit_struct_arch of xor_nbit_struct is

    component xor
        port(
            i_a             : in std_logic;
            i_b             : in std_logic;
            o_z             : out std_logic
            );
    end component;

    begin

        -- We loop through xor instantiate xor connect N invg modules
        G1: for i in 0 to N generate
            xor_i: xor 
                port map(
                    i_a       => i_a(i),
                    i_b       => i_b(i),
                    o_z       => o_z(i)
                        );
        end generate;

  
end xor_nbit_struct_arch;