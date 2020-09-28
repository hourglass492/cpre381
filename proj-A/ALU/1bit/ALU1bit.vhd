library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity ALU1bit is
  port(
     
    in_ia              : in std_logic;
    in_ib              : in std_logic;
    in_ctl             : in std_logic_vector(0 to 2);


    out_data            : in std_logic;
    out_overflow        : out std_logic;
    out_carry           : out std_logic;
    out_zero            : out std_logic

	);
	
end ALU1bit;

architecture ALU_arch of ALU1bit is


    signal internal_and                : std_logic;
    signal internal_not_and            : std_logic;
    signal internal_or                 : std_logic;
    signal internal_xor                : std_logic;
    signal internal_sum                : std_logic;

    signal internal_sum_msb            : std_logic;
    signal internal_adder_overflow     : std_logic;
    signal internal_mux_input          : muxVector;


    

    signal high                        : std_logic := '1';
    signal low                         : std_logic := '0';
    signal internal_mem_we	           : std_logic;
    signal internal_addsub_ctl         : std_logic;					-- set to high to let the memory load values
    signal internal_mem_reg_we	       : std_logic;
    signal internal_reg_we	            : std_logic;
    signal nothing	                    : std_logic;











--The 2 is the log2_Of_num_of_inputs
--type muxVector is array(0 to 2 +1) of inputVectors;

--XXXXXXXXXXXXXXXXXX THIS WILL BE VERY BUGGY XXXXXXXXXXXXXXXXXXXXXXXX
    component mux_nbit_nbitto1_struct

        generic(data_size : integer := data_size; 
          num_of_inputs : integer := 7;
          log2_Of_num_of_inputs : integer := 2
          );

        port(
          in_data_0         : in muxVectors;
          in_select        : in std_logic_vector(0 to 2);
          o_z              : out std_logic_vector(0 to data_size)
      
          );
          





    end component



    component add_sub_struct_1bit
        port(

          i_a             : in std_logic;
          i_b             : in std_logic;
          i_select        : in std_logic;
          i_carry         : in std_logic;
          o_sum           : out std_logic;
          o_carry         : out std_logic
      
          );
          
      end component;


    begin
	












        
    --XXXXXXXXXXXXXXXXXXXXXXXXXX need to do adder select signal

    addSub: add_sub_struct_1bit
        port map(
            i_a             => in_ia,
            i_b             => in_ib,
            i_select        => internal_addsub_ctl,
            i_carry         => i_carry,
            o_sum           => muxVector(4),
            o_carry         => out_carry 
        );









end ALU_arch;