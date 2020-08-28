library IEEE;
use IEEE.std_logic_1164.all;

entity adder_nbit_flow is
  generic(N : integer := 32);
  port(
     


    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_carry         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_carry         : out std_logic

	);
	
end adder_nbit_flow;

architecture adder_nbit_flow_arch of adder_nbit_flow is

    inter_carry : std_logic_vector(0 to N+1);

    begin



        inter_carry = std_logic_vector + std_logic_vector;


        o_sum   <= inter_carry(0 to N);
        o_carry <= inter_carry(N);



end adder_nbit_flow_arch;