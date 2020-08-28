library IEEE;
use IEEE.std_logic_1164.all;

entity mux is

  port(
     
    i_a             : in std_logic;
    i_b             : in std_logic;
    i_select        : in std_logic;
    o_z             : out std_logic

	);
	
end mux;

architecture mux_arch of mux is

    signal inter_1 inter_2 inter_3 : std_logic

    component invg
        port(
            i_A     : in std_logic;
            o_F     : out std_logic
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
         o_F         : out std_logic);
        );
    end component;

    begin

        -- We loop through and instantiate and connect N invg modules

            invg: invg 
                port map(
                        i_A  => i_select,
                        o_F  => inter_1
                        );

            
            andg2_1: andg2
                port map(
                    i_A => inter_1,
                    i_B => i_b,
                    o_F => inter_3
                );

            andg2_2: andg2
                port map(
                    i_A => i_select,
                    i_B => i_a,
                    o_F => inter_3
                );

            org2_1: org2
                port map(
                    i_A =>inter_2      
                    i_B => inter_3     
                    o_F => o_z 
                );

  
end mux_arch;