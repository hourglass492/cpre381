library IEEE;
use IEEE.std_logic_1164.all;

entity struc_inverter is
  generic(N : integer := 32);
  port(
     
    input      : in std_logic_vector(0 to N);
    output     : out std_logic_vector(0 to N);

end struc_inverter;

architecture structure of struc_inverter is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

begin

-- We loop through and instantiate and connect N invg modules
G1: for i in 0 to N-1 generate
  and_i: andg2 
    port map(i_A  => i_A(i),
  	          o_F  => o_F(i));
end generate;

  
end structure;