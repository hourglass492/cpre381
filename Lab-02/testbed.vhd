library IEEE;
use IEEE.std_logic_1164.all;

entity testbed is
  generic(N : integer := 32);
  port(
     
    data      : in std_logic_vector(0 to N);
    out_struct     : out std_logic_vector(0 to N);
    out_flow     : out std_logic_vector(0 to N)
	);
	
end testbed;

architecture testbed_arch of testbed is

    component structual_1Complement
        port(
            i_a  : in std_logic_vector(0 to N);
            o_z  : out std_logic_vector(0 to N)
            );
    end component;

    component data_flow_1Complement
    port(
        input  : in std_logic_vector(0 to N);
        output  : out std_logic_vector(0 to N)
        );
end component;

    begin

        -- We loop through and instantiate and connect N invg modules

        structual: structual_1Complement 
            port map(
                    i_a  => data,
                    o_z  => out_struct
                    );

        data_flow: data_flow_1Complement 
            port map(
                    input  => data,
                    output  => out_flow
                    );
            

  
end testbed_arch;