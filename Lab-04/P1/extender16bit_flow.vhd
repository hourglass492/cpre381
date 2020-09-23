library IEEE;
use IEEE.std_logic_1164.all;

entity extender16bit_flow is
    generic(N : integer := 15);

  port(i_control    : in std_logic;     -- 0 to extend sign, 1 to extend 0's
       i_D          : in std_logic_vector( 0 to N);     -- Data input
       o_Q          : out std_logic_vector( 0 to 31)       -- Data  output
);
end extender16bit_flow;

architecture extender16bit_flow_arch of extender16bit_flow is

begin



	-- asign the extended va;ues
    G1: for j in 0 to N generate
 	o_Q(j) <= i_D(0) and not i_control;
        
    end generate;


    --assign all of the current values
    G2: for j in N+1 to 31 generate

      o_Q(j) <= i_D(j-1-N);

    end generate;
    
  
end extender16bit_flow_arch;