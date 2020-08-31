library IEEE;
use IEEE.std_logic_1164.all;

entity add_sub is
  generic(N : integer := 32);
  port(
     


    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_overflow         : out std_logic

	);
	
end add_sub;

architecture add_sub_arch of add_sub is

    inter_carry : std_logic_vector(0 to N+1);

    component adder
        port(
            i_a             : in std_logic;
            i_b             : in std_logic;
            i_carry         : in std_logic;
            o_sum           : out std_logic;
            o_carry         : out std_logic
            );
    end component;

    component adder
    port(
        i_a             : in std_logic;
        i_b             : in std_logic;
        i_carry         : in std_logic;
        o_sum           : out std_logic;
        o_carry         : out std_logic
        );
    end component;


    component adder
    port(
        i_a             : in std_logic;
        i_b             : in std_logic;
        i_carry         : in std_logic;
        o_sum           : out std_logic;
        o_carry         : out std_logic
        );
    end component;



    begin


        inter_carry(0) <= i_carry;
        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N generate
            adder_i: adder 
                port map(
                    i_a       => i_a(i),
                    i_b       => i_b(i),
                    i_carry   => inter_carry(i),
                    o_sum     => o_sum(i),
                    o_carry   => inter_carry(i+1)
                        );

        end generate;

        o_carry <= inter_carry(N);



end add_sub_arch;