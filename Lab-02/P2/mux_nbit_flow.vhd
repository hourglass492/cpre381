library IEEE;
use IEEE.std_logic_1164.all;

entity mux_nbit_flow is
  generic(N : integer := 32);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select        : in std_logic;
    o_z             : out std_logic_vector(0 to N)

	);
	
end mux_nbit_flow;

architecture mux_nbit_flow_arch of mux_nbit_flow is

    begin

        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N-1 generate
            o_z(i) <= (i_a(i) and i_select) or (i_b(i) or (not i_select));
        end generate;

  
end mux_nbit_flow_arch;