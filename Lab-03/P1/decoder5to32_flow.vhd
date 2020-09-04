

library IEEE;
use IEEE.std_logic_1164.all;

entity decoder5to32_flow is

  port(
       i_data        : in std_logic_vector(0 to 5);     
       o_data        : out std_logic_vector(0 to 32)
  );

end decoder5to32_flow;

architecture decoder5to32_flow_arch of decoder5to32_flow is


begin

o_data(0) <=  not i_data(0) and not i_data(1) and not i_data(2) and not i_data(3) and  not i_data(4);
o_data(1) <=  not i_data(0) and not i_data(1) and not i_data(2) and not i_data(3) and      i_data(4);
o_data(2) <=  not i_data(0) and not i_data(1) and not i_data(2) and     i_data(3) and  not i_data(4);
o_data(3) <=  not i_data(0) and not i_data(1) and not i_data(2) and     i_data(3) and      i_data(4);
o_data(4) <=  not i_data(0) and not i_data(1) and     i_data(2) and not i_data(3) and  not i_data(4);
o_data(5) <=  not i_data(0) and not i_data(1) and     i_data(2) and not i_data(3) and      i_data(4);
o_data(6) <=  not i_data(0) and not i_data(1) and     i_data(2) and     i_data(3) and  not i_data(4);
o_data(7) <=  not i_data(0) and not i_data(1) and     i_data(2) and     i_data(3) and      i_data(4);
o_data(8) <=  not i_data(0) and     i_data(1) and not i_data(2) and not i_data(3) and  not i_data(4);
o_data(9) <=  not i_data(0) and     i_data(1) and not i_data(2) and not i_data(3) and      i_data(4);
o_data(10) <=  not i_data(0) and     i_data(1) and not i_data(2) and     i_data(3) and  not i_data(4);
o_data(11) <=  not i_data(0) and     i_data(1) and not i_data(2) and     i_data(3) and      i_data(4);
o_data(12) <=  not i_data(0) and     i_data(1) and     i_data(2) and not i_data(3) and  not i_data(4);
o_data(13) <=  not i_data(0) and     i_data(1) and     i_data(2) and not i_data(3) and      i_data(4);
o_data(14) <=  not i_data(0) and     i_data(1) and     i_data(2) and     i_data(3) and  not i_data(4);
o_data(15) <=  not i_data(0) and     i_data(1) and     i_data(2) and     i_data(3) and      i_data(4);
o_data(16) <=      i_data(0) and not i_data(1) and not i_data(2) and not i_data(3) and  not i_data(4);
o_data(17) <=      i_data(0) and not i_data(1) and not i_data(2) and not i_data(3) and      i_data(4);
o_data(18) <=      i_data(0) and not i_data(1) and not i_data(2) and     i_data(3) and  not i_data(4);
o_data(19) <=      i_data(0) and not i_data(1) and not i_data(2) and     i_data(3) and      i_data(4);
o_data(20) <=      i_data(0) and not i_data(1) and     i_data(2) and not i_data(3) and  not i_data(4);
o_data(21) <=      i_data(0) and not i_data(1) and     i_data(2) and not i_data(3) and      i_data(4);
o_data(22) <=      i_data(0) and not i_data(1) and     i_data(2) and     i_data(3) and  not i_data(4);
o_data(23) <=      i_data(0) and not i_data(1) and     i_data(2) and     i_data(3) and      i_data(4);
o_data(24) <=      i_data(0) and     i_data(1) and not i_data(2) and not i_data(3) and  not i_data(4);
o_data(25) <=      i_data(0) and     i_data(1) and not i_data(2) and not i_data(3) and      i_data(4);
o_data(26) <=      i_data(0) and     i_data(1) and not i_data(2) and     i_data(3) and  not i_data(4);
o_data(27) <=      i_data(0) and     i_data(1) and not i_data(2) and     i_data(3) and      i_data(4);
o_data(28) <=      i_data(0) and     i_data(1) and     i_data(2) and not i_data(3) and  not i_data(4);
o_data(29) <=      i_data(0) and     i_data(1) and     i_data(2) and not i_data(3) and      i_data(4);
o_data(30) <=      i_data(0) and     i_data(1) and     i_data(2) and     i_data(3) and  not i_data(4);
o_data(31) <=      i_data(0) and     i_data(1) and     i_data(2) and     i_data(3) and      i_data(4);

  
end decoder5to32_flow_arch;
