library IEEE;
use IEEE.std_logic_1164.all;

entity or_nbit_struct is
  generic(N : integer := 31);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    o_z             : out std_logic_vector(0 to N)

	);
	
end or_nbit_struct;

architecture or_nbit_struct_arch of or_nbit_struct is

    component or
        port(
            i_a             : in std_logic;
            i_b             : in std_logic;
            o_z             : out std_logic
            );
    end component;

    begin

        -- We loop through or instantiate or connect N invg modules
        G1: for i in 0 to N generate
            or_i: or 
                port map(
                    i_a       => i_a(i),
                    i_b       => i_b(i),
                    o_z       => o_z(i)
                        );
        end generate;

  
end or_nbit_struct_arch;