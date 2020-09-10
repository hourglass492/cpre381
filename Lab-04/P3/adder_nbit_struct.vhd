library IEEE;
use IEEE.std_logic_1164.all;

entity adder_nbit_struct is
  generic(N : integer := 31);
  port(
     


    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_carry         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_carry         : out std_logic

	);
	
end adder_nbit_struct;

architecture adder_nbit_struct_arch of adder_nbit_struct is

    signal inter_carry : std_logic_vector(0 to N+1);

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


	inter_carry(N+1) <= i_carry;
	o_carry <= inter_carry(0);






        -- We loop through and instantiate and connect N invg modules
        G1: for i in 0 to N generate
            adder_i: adder 
                port map(
                    i_a       => i_a(i),
                    i_b       => i_b(i),
                    i_carry   => inter_carry(i+1),
                    o_sum     => o_sum(i),
                    o_carry   => inter_carry(i)
                        );

        end generate;



end adder_nbit_struct_arch;