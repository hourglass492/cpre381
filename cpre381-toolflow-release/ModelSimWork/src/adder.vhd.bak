library IEEE;
use IEEE.std_logic_1164.all;

entity adder is

  port(
     
    i_a             : in std_logic;
    i_b             : in std_logic;
    i_carry         : in std_logic;
    o_sum           : out std_logic;
    o_carry         : out std_logic

	);
	
end adder;

architecture adder_arch of adder is

    signal inter_1, inter_2, inter_3 : std_logic;

    component xorg2
        port(
         i_A         : in std_logic;
         i_B         : in std_logic;
         o_F         : out std_logic
            );
    end component;

    component org2
    port(
         i_A         : in std_logic;
         i_B         : in std_logic;
         o_F         : out std_logic
        );
    end component;

    component andg2
    port(
         i_A         : in std_logic;
         i_B         : in std_logic;
         o_F         : out std_logic
        );
    end component;

    begin

        
            xorg2_1: xorg2
                port map(
                    i_A => i_a,      
                    i_B => i_b,    
                    o_F => inter_1 
                );

            xorg2_2: xorg2
                port map(
                    i_A => inter_1,      
                    i_B => i_carry,    
                    o_F => o_sum 
                );
                


            
            andg2_1: andg2
                port map(
                    i_A => inter_1,
                    i_B => i_carry,
                    o_F => inter_2
                );

            andg2_2: andg2
                port map(
                    i_A => i_a,
                    i_B => i_b,
                    o_F => inter_3
                );

            org2_1: org2
                port map(
                    i_A => inter_2,      
                    i_B => inter_3,    
                    o_F => o_carry 
                );

  
end adder_arch;