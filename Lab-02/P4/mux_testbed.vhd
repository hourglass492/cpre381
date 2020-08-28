library IEEE;
use IEEE.std_logic_1164.all;

entity mux_testbed is
  generic(N : integer := 32);
  port(
     
    data_a                    : in std_logic_vector(0 to N);
    data_b                    : in std_logic_vector(0 to N);
    i_select                  : in std_logic;
    out_struct                : out std_logic_vector(0 to N);
    out_flow                  : out std_logic_vector(0 to N)
	);
	
end mux_testbed;

architecture mux_testbed_arch of mux_testbed is

    component mux_nbit_struct
        port(
            i_a             : in std_logic_vector(0 to N);
            i_b             : in std_logic_vector(0 to N);
            i_select        : in std_logic;
            o_z             : out std_logic_vector(0 to N)
            );
    end component;

    component mux_nbit_flow
    port(
        i_a             : in std_logic_vector(0 to N);
        i_b             : in std_logic_vector(0 to N);
        i_select        : in std_logic;
        o_z             : out std_logic_vector(0 to N)
        );
end component;

    begin

        -- We loop through and instantiate and connect N invg modules

        structual: mux_nbit_struct 
            port map(
                    i_a  => data_a,
                    i_b  => data_b,
                    i_select => i_select,
                    o_z  => out_struct
                    );

        data_flow: mux_nbit_flow 
            port map(
                    i_a  => data_a,
                    i_b  => data_b,
                    i_select => i_select,
                    o_z  => out_flow
                    );
            

  
end mux_testbed_arch;