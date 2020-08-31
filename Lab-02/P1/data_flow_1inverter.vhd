library IEEE;
use IEEE.std_logic_1164.all;

entity data_flow_1Complement is
  generic(N : integer := 32);
  port(
     
    input      : in std_logic_vector(0 to N);
    output     : out std_logic_vector(0 to N)
	);
	
end data_flow_1Complement;

architecture data_flow_1Complement_arch of data_flow_1Complement is


    begin

        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N generate

            output(i)  <= not input(i);
        end generate;

  
end data_flow_1Complement_arch;