library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity and_nbit_nbitto1_struct is
  
    port(

      in_data_0        : in inputVectors;
      o_z              : out std_logic_vector(0 to data_size)
  
      );
      
  end and_nbit_nbitto1_struct;
  
  architecture and_nbit_nbitto1_struct_arch of and_nbit_nbitto1_struct is
  
      signal internal : internalCarry; 
  
  
  
      component or_nbit_struct
          port(
              i_a             : in std_logic_vector(0 to data_size);
              i_b             : in std_logic_vector(0 to data_size);
              o_z             : out std_logic_vector(0 to data_size)
              );
      end component;
  
      begin
  
      G_1st_assign: for i in 0 to num_of_inputs generate
            internal(0)(i) <= in_data_0(num_of_inputs-i);
        end generate;
  
  
  
  
      G2_1: for j in 0 to log2_Of_num_of_inputs generate
          G2_2: for i in 0 to num_of_inputs/(2**(j+1)) generate --for first round we want half as many mux's as inputs so add 1 to j to make it num_of_inputs/2
              add_j_i: mux_nbit_struct 
              port map(
                  i_a       => internal(j)(2*i),
                  i_b       => internal(j)((2*i)+1),
                  o_z        => internal(j+1)(i)
                      );
  
          end generate;
      end generate;
  
      o_z <= internal(log2_Of_num_of_inputs+1)(0);
  
    
  end and_nbit_nbitto1_struct_arch;