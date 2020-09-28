library IEEE;
use IEEE.std_logic_1164.all;

entity not_nbit_struct is
  generic(N : integer := 31);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    o_z             : out std_logic_vector(0 to N)

	);
	
end not_nbit_struct;

architecture not_nbit_struct_arch of not_nbit_struct is


    begin

        G1: for i in 0 to N generate
            o_z(i) <= not i_a(i);

        end generate;

  
end not_nbit_struct_arch;