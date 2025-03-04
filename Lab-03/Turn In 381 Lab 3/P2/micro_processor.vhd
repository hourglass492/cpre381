library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity micro_processor is
    -- If you cange n you must remake the decoder function
  generic(N : integer := 31 );
  port(
     
    in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);


    in_immedate_value  : in std_logic_vector(0 to N);
    in_control         : in std_logic_vector(0 to 1);

    i_CLK              : in std_logic;
    i_RST              : in std_logic

	);
	
end micro_processor;

architecture micro_processor_arch of micro_processor is


    signal internal_rs       : std_logic_vector(0 to N);
    signal internal_rt       : std_logic_vector(0 to N);
    signal internal_mux      : std_logic_vector(0 to N);
    signal internal_sum      : std_logic_vector(0 to N);
    signal high              : std_logic := '1';
    signal low               : std_logic := '0';

	component registerFile_nbit_struct
		port(
            i_rd               : in std_logic_vector(0 to N);
            in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
            in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
            in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
            i_WE               : in std_logic;
            i_CLK              : in std_logic;
            i_RST              : in std_logic;
        
        
            o_rt               : out std_logic_vector(0 to N);
            o_rs               : out std_logic_vector(0 to N)


			);
	end component;
		



    component add_sub_struct
        port(
            i_a             : in std_logic_vector(0 to N);
            i_b             : in std_logic_vector(0 to N);
            i_select         : in std_logic;
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



    begin

        
    -- Everything but this circuit can scale up YOU MUST REBUILD THIS TO CHANGE N
    mux: mux_nbit_struct 
        port map(
                    i_a         => in_immedate_value,
                    i_b         => internal_rt,  
                    i_select    => in_control(0),
                    o_z         => internal_mux    
                );








    ACLU: add_sub_struct
        port map(
            i_a             => internal_rs,
            i_b             => internal_mux,
            i_select        => in_control(1),
            o_sum           => internal_sum
            -- o_carry         not useing carry right now
        );




    -- mux to output the rt data
    register_file: registerFile_nbit_struct
    port map(
        i_rd               => internal_sum, --value to load
        in_select_rs       => in_select_rs, -- next 3 select the register to pull from for each value
        in_select_rt       => in_select_rt,
        in_select_rd       => in_select_rd,
        i_WE               => high,
        i_CLK              => i_CLK,
        i_RST              => i_RST,
    
    
        o_rt               => internal_rt,
        o_rs               => internal_rs
    );







end micro_processor_arch;