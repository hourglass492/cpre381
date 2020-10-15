library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;



entity pc is 
    port(  
        i_branch                : in std_logic;
        i_zero                  : in std_logic;
        i_immedate              : in std_logic_vector(0 to 31);




        o_instruction_number    : out std_logic_vector(0 to 31)


    );

end pc;



architecture pc_arch of pc is

    signal next_pc           : std_logic_vector(0 to data_size);
    signal add_4             : std_logic_vector(0 to data_size);
    signal add_input         : std_logic_vector(0 to data_size);
    signal branch_or_add     : std_logic;
    signal shifted_input     : std_logic_vector(0 to data_size);
    signal last_counter      : std_logic_vector(0 to data_size);

    component register_nbit_struct
        port(
            i_CLK             : in std_logic;
            i_RST             : in std_logic;
            i_WE              : in std_logic;
            i_D               : in std_logic_vector(0 to data_size);   
        
            o_Q               : out std_logic_vector(0 to data_size)
            );
    end component;


    component adder_nbit_struct
        port(
           
            i_a             : in std_logic_vector(0 to data_size);
            i_b             : in std_logic_vector(0 to data_size);
            i_carry         : in std_logic;
            o_sum           : out std_logic_vector(0 to data_size);
            o_carry         : out std_logic
      
          );
          
    end component;



    component mux_nbit_struct
        port(
           
          i_a             : in std_logic_vector(0 to data_size);
          i_b             : in std_logic_vector(0 to data_size);
          i_select        : in std_logic;
          o_z             : out std_logic_vector(0 to data_size)
      
          );
          
    end component;


begin


    branch_or_add <= i_branch and i_zero;


    branch_or_add_mux: mux 
        port map(
            i_a       => add_4,
            i_b       => add_input,
            i_select  => branch_or_add,
            o_z       => next_pc
    );


    --TODO I need to figure out how to shift this
    shifted_input <= i_immedate * 4;

    -- add the input and the shifted value 
    immedate_adder: adder_nbit_struct 
        port map(
            i_a       => add_4,
            i_b       => shifted_input,

            o_z       => add_input
    );


    -- add the input and the shifted value
    -- TODO does the add 4 immideate value work 
    four_adder: adder_nbit_struct 
        port map(
            i_a       => last_counter,
            i_b       => 4,

            o_z       => add_4
    );








end pc_arch;









