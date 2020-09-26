library IEEE;
use IEEE.std_logic_1164.all;

entity add_sub_struct is
  generic(N : integer := 32);
  port(
     


    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_carry         : out std_logic

	);
	
end add_sub_struct;

architecture add_sub_struct_arch of add_sub_struct is

        signal inter_carry_1 : std_logic_vector(0 to N);
        signal inter_carry_2 : std_logic_vector(0 to N);

        component adder_nbit_struct
            port(
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_carry         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_carry         : out std_logic
                );
        end component;


        component mux_nbit_struct
            port(
                i_a             : in std_logic_vector(0 to N);
                i_b             : in std_logic_vector(0 to N);
                i_select        : in std_logic;
                o_z             : out std_logic_vector(0 to N)
                );
        end component;

        component structual_1Complement
            port(
                i_a      : in std_logic_vector(0 to N);
                o_z     : out std_logic_vector(0 to N)
                );
        end component;

    begin

    inverter: structual_1Complement 
        port map(
                    i_a      => i_b,
                    o_z      => inter_carry_1     
                );


    mux: mux_nbit_struct 
        port map(
                    i_a       => inter_carry_1,
                    i_b       => i_b,
                    i_select  => i_select,
                    o_z       => inter_carry_2
                );



    adder: adder_nbit_struct 
        port map(
                    i_a       => i_a,
                    i_b       => inter_carry_2,
                    i_carry   => i_select,
                    o_sum     => o_sum,
                    o_carry   => o_carry
                );






end add_sub_struct_arch;