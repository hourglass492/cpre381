library IEEE;
use IEEE.std_logic_1164.all;

entity muxg is

  port(
     
    i_a             : in std_logic;
    i_b             : in std_logic;
    i_select        : in std_logic;
    o_z             : out std_logic

	);
	
end muxg;

architecture mux_arch of muxg is


    begin

        -- We loop through and instantiate and connect N invg modules

        o_z <= i_a when (i_select = '1')
                    else i_b when (i_select  = '0');

end mux_arch;