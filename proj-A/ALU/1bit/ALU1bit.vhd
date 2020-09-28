library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity ALU1bit is
  generic(numOfOperations : integer := 7);

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
    signal internal_result_vector      : std_logic_vector(0 to numOfOperations);


    

    signal ctl_and                        : std_logic := '1';
    signal ctl_or                         : std_logic := '0';
    signal ctl_xor	                      : std_logic;
    signal ctl_nand                       : std_logic;					-- set to high to let the memory load values
    signal ctl_nor	                      : std_logic;
    signal ctl_add	                      : std_logic;
    signal ctl_sub	                      : std_logic;
    signal ctl_slt	                      : std_logic;











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


      ctl_and     <= in_ctl(0)     and in_ctl(1)      and in_ctl(2);
      ctl_or      <= in_ctl(0)     and in_ctl(1)      and not in_ctl(2);
      ctl_xor     <= in_ctl(0)     and not in_ctl(1)  and in_ctl(2);
      ctl_nand    <= in_ctl(0)     and not in_ctl(1)  and not in_ctl(2);
      ctl_nor     <= not in_ctl(0) and in_ctl(1)      and in_ctl(2);
      ctl_add     <= not in_ctl(0) and in_ctl(1)      and not in_ctl(2);
      ctl_sub     <= not in_ctl(0) and not in_ctl(1)  and in_ctl(2);
      ctl_slt     <= not in_ctl(0) and not in_ctl(1)  and not in_ctl(2);
  
      


      internal_result_vector(0) <= in_ia and in_ib;

      

      internal_result_vector(1) <= in_ia or in_ib;


      internal_result_vector(2) <= in_ia xor in_ib;



      internal_result_vector(3) <= in_ia nand in_ib;


      internal_result_vector(4) <= in_ia nor in_ib;














        
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

        muxVector(5) <= muxVector(4);


      
      internal_result_vector(0) <= out_carry xor muxVector(4);




        out_data <= internal_result_vector(7) when ctl_and 
               else internal_result_vector(6) when ctl_or 
               else internal_result_vector(5) when ctl_xor 
               else internal_result_vector(4) when ctl_nand 
               else internal_result_vector(3) when ctl_nor 
               else internal_result_vector(2) when ctl_add 
               else internal_result_vector(1) when ctl_sub 
               else internal_result_vector(0) when ctl_slt 




end ALU_arch;