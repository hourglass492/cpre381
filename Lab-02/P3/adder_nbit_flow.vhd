library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity adder_nbit_flow is
  generic(N : integer := 32);
  port(
     


    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_carry         : in std_logic;
    o_sum           : out std_logic_vector(0 to N)
	);
	
end adder_nbit_flow;

architecture adder_nbit_flow_arch of adder_nbit_flow is


    begin





        o_sum   <= std_logic_vector(signed(i_a) + signed(i_b));



end adder_nbit_flow_arch;