library IEEE;
use IEEE.std_logic_1164.all;

entity structual_1Complement is
  generic(N : integer := 31);
  port(
     
    i_a      : in std_logic_vector(0 to N);
    o_z      : out std_logic_vector(0 to N)
	);
	
end structual_1Complement;

architecture structual_1Complement_arch of structual_1Complement is

    component invg
        port(
            i_A  : in std_logic;
            o_F  : out std_logic
            );
    end component;

    begin

        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N generate
            invg_i: invg 
                port map(
                        i_A  => i_a(i),
                        o_F  => o_z(i)
                        );
        end generate;

  
end structual_1Complement_arch;