library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity ALU is
  port(
     
    in_ia              : in std_logic_vector(0 to data_size);
    in_ib              : in std_logic_vector(0 to data_size);
    in_ctl             : in std_logic_vector(0 to 2);


    out_data            : in std_logic_vector(0 to data_size);
    out_overflow        : out std_logic;
    out_carry           : out std_logic;
    out_zero            : out std_logic

	);
	
end ALU;

architecture ALU_arch of ALU is
    type muxVector is array(0 to 2 +1) of inputVectors;


    signal internal_and                : std_logic_vector(0 to N);
    signal internal_not_and            : std_logic_vector(0 to N);
    signal internal_or                 : std_logic_vector(0 to N);
    signal internal_xor                : std_logic_vector(0 to N);
    signal internal_sum                : std_logic_vector(0 to N);

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

    type internalCarry is array(0 to 2+1) of inputVectors;






component add_sub_struct
  generic(N : integer := data_size);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_carry         : out std_logic

	);
	
end component;




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
          
 
    end component;




    component and_nbit_struct
  
        port(
    
            i_a             : in std_logic_vector(0 to N);
            i_b             : in std_logic_vector(0 to N);
            o_z             : out std_logic_vector(0 to N)
      
          );
          
    end component;



    component nand_nbit_struct
  
        port(
    
            i_a             : in std_logic_vector(0 to N);
            i_b             : in std_logic_vector(0 to N);
            o_z             : out std_logic_vector(0 to N)
      
          );
          
    end component;


    component or_nbit_struct is
  
        port(
            i_a             : in std_logic_vector(0 to N);
            i_b             : in std_logic_vector(0 to N);
            o_z             : out std_logic_vector(0 to N)
      
          );
          
    end component;



    component xor_nbit_struct
  
        port(
    
            i_a             : in std_logic_vector(0 to N);
            i_b             : in std_logic_vector(0 to N);
            o_z             : out std_logic_vector(0 to N)
      
          );
          
    end component;


    component not_nbit_struct
  
    port(

        i_a             : in std_logic_vector(0 to N);
        o_z             : out std_logic_vector(0 to N)
  
      );
      
end component;





















    begin
	





    extender: extender16bit_flow
        port map(
            i_control    => low,     -- 0 to extend sign, 1 to extend 0's
            i_D          => in_immedate_value,     -- Data input
            o_Q          => internal_imm 
        );






    and_nbit: and_nbit_struct
        port(

            i_a             => in_ia,
            i_b             => in_ib,
            o_z             => muxVector(0) 
    
        );
        




    nand_nbit: nand_nbit_struct
        port(

            i_a             => in_ia,
            i_b             => in_ib,
            o_z             => muxVector(1)
    
        );
        



    or_nbit: or_nbit_struct is
        port(
            i_a             => in_ia,
            i_b             => in_ib,
            o_z             => muxVector(2)
    
        );
        




    xor_nbit: xor_nbit_struct
        port(

            i_a             => in_ia,
            i_b             => in_ib,
            o_z             => muxVector(3)
    
        );
        
    --XXXXXXXXXXXXXXXXXXXXXXXXXX need to do adder select signal

    addSub: add_sub_struct
        port map(
            i_a             => in_ia,
            i_b             => in_ib,
            i_select        => internal_addsub_ctl,
            o_sum           => muxVector(4),
             o_carry        => internal_adder_overflow-- not useing carry right now
        );

    --Add and subtract get the same output because they both come from the adder
    muxVector(4) <= muxVector(3);


    --Make sure this isn't backwards
    -- it should take the most Significant bit from the adder sum and use it 
    -- because it will be one if negitve and assign the rest of the bits to zero
    muxVector(5)(data_size) <=  muxVector(3)(0);
    G1:  for j in 0 to data_size-1 generate
        muxVector(5)(j) <= '0';
    end generate;





    out_overflow <= muxVector(3)(0) xor internal_adder_overflow;






    --Need to make the or logic for the zero








end ALU_arch;