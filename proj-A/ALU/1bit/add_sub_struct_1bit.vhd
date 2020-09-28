library IEEE;
use IEEE.std_logic_1164.all;

entity add_sub_struct_1bit is
  port(
     


    i_a             : in std_logic;
    i_b             : in std_logic;
    i_select        : in std_logic;
    i_carry         : in std_logic;
    o_sum           : out std_logic;
    o_carry         : out std_logic

	);
	
end add_sub_struct_1bit;

architecture add_sub_struct_1bit_arch of add_sub_struct_1bit is

        signal inter_carry_1 : std_logic;
        signal inter_carry_2 : std_logic;

        component adder
            port(
                i_a             : in std_logic;
                i_b             : in std_logic;
                i_carry         : in std_logic;
                o_sum           : out std_logic;
                o_carry         : out std_logic
                );
        end component;


        component mux
            port(
                i_a             : in std_logic;
                i_b             : in std_logic;
                i_select        : in std_logic;
                o_z             : out std_logic
                );
        end component;


    begin


    inter_carry_1  <= not i_b;




    mux: mux
        port map(
                    i_a       => inter_carry_1,
                    i_b       => i_b,
                    i_select  => i_select,
                    o_z       => inter_carry_2
                );



    adder: adder 
        port map(
                    i_a       => i_a,
                    i_b       => inter_carry_2,
                    i_carry   => i_carry,
                    o_sum     => o_sum,
                    o_carry   => o_carry
                );






end add_sub_struct_1bit_arch;