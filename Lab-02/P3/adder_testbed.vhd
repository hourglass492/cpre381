library IEEE;
use IEEE.std_logic_1164.all;

entity adder_testbed is
  generic(N : integer := 32);
  port(
     
    i_a                    : in std_logic_vector(0 to N);
    i_b                    : in std_logic_vector(0 to N);
    i_carry                : in std_logic;
    o_sum_struct           : out std_logic_vector(0 to N);
    o_carry_struct         : out std_logic;
    o_sum_flow             : out std_logic_vector(0 to N)



	);
	
end adder_testbed;

architecture adder_testbed_arch of adder_testbed is

    component adder_nbit_flow
        port(
             i_a             : in std_logic_vector(0 to N);
             i_b             : in std_logic_vector(0 to N);
             i_carry         : in std_logic;
             o_sum           : out std_logic_vector(0 to N)
            );
    end component;

    component adder_nbit_struct
    port(
         i_a             : in std_logic_vector(0 to N);
         i_b             : in std_logic_vector(0 to N);
         i_carry         : in std_logic;
         o_sum           : out std_logic_vector(0 to N);
         o_carry         : out std_logic
        );
end component;

    begin




        struct: adder_nbit_struct
            port map (
                        i_a        =>  i_a,
                        i_b        =>  i_b,
                        i_carry    =>  i_carry,
                        o_sum      =>  o_sum_struct,
                        o_carry    =>  o_carry_struct
                    );





        flow: adder_nbit_flow
                    port map (
                                i_a        =>  i_a,
                                i_b        =>  i_b,
                                i_carry    =>  i_carry,
                                o_sum      =>  o_sum_flow
                            );


  
end adder_testbed_arch;