-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- generate_example.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an example of using generic ports to
-- drive a "generate / for" block. 
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 1/25/19 by H3::Fixed name conflict with and2 and Quartus.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity generate_example  is
  generic(N : integer := 14);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       o_F  : out std_logic_vector(N-1 downto 0));

end generate_example;

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
