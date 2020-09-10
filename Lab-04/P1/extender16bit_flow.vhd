library IEEE;
use IEEE.std_logic_1164.all;

entity extender16bit_flow is
    generic(N : integer := 15);

  port(i_control    : in std_logic;     -- 0 to extend sign, 1 to extend 0's
       i_D          : in std_logic_vector( 0 to N);     -- Data input
       o_Q          : in std_logic_vector( 0 to 31;       -- Data  output

end extender16bit_flow;

architecture extender16bit_flow_arch of extender16bit_flow is

begin



    --assign all of the current values
    G1: for j in 0 to N generate
        o_Q(j) <= i_D(j);
    end generate;



    G2: for j in N+1 to 31
        if (i_control = '1') then
            s_Q(j) <= '0'; -- 1 extends zeros
        else then
            s_Q(j) <= s_D(N);
        end if;
  
end extender16bit_flow_arch;