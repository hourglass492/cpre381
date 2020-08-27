library IEEE;
use IEEE.std_logic_1164.all;

entity structual_1Complement is
  generic(N : integer := 32);
  port(
     
    input      : in std_logic_vector(0 to N);
    output     : out std_logic_vector(0 to N)
	);
	
end structual_1Complement;

architecture structual_1Complement_arch of structual_1Complement is


    begin

        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N-1 generate

            output(i)  <= not input(i);
        end generate;

  
end structual_1Complement_arch;