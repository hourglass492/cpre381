library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package instruction_buffer_type is
	constant data_size : integer := 4;  --bits wide
	constant num_of_inputs    : integer := 31; --bits wide
	constant log2_Of_num_of_inputs : integer := 4;
	type inputVectors is array(0 to num_of_inputs) of std_logic_vector (0 to data_size);
	type internalCarry is array(0 to log2_Of_num_of_inputs+1) of inputVectors;
end package instruction_buffer_type;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;


entity mux_nbit_nbitto1_struct is
  generic(data_size : integer := 31; 
	num_of_inputs : integer := 31;
	log2_Of_num_of_inputs : integer := 4
	);





  port(
     

   --G0: for i in 0 to num_of_inputs generate
        in_data_0    : in inputVectors;

   --end generate;



    in_select        : in std_logic_vector(0 to log2_Of_num_of_inputs);
    o_z              : out std_logic_vector(0 to data_size)

	);
	
end mux_nbit_nbitto1_struct;

architecture mux_nbit_nbitto1_struct_arch of mux_nbit_nbitto1_struct is

	
    -- generate all the internal signals
    -- you need half as many internal carries as inputs from the previous
    -- number of inputs
--    G11: for j in 0 to log2_Of_num_of_inputs + 1 generate begin --need to assign the input values to j=0 set
--        	G1: for i in 0 to num_of_inputs/(j**2) generate begin
--			
--            			signal in_data_j_i : std_logic_vector(0 to data_size);

 --       	end generate;
 --   end generate;

	signal internal : internalCarry; 



    component mux_nbit_struct
        port(
            i_a             : in std_logic_vector(0 to data_size);
            i_b             : in std_logic_vector(0 to data_size);
            i_select        : in std_logic;
            o_z             : out std_logic_vector(0 to data_size)
            );
    end component;

    begin

    G_1st_assign: for i in 0 to num_of_inputs generate

	internal(0)(i) <= in_data_0(num_of_inputs-i);


     end generate;




    G2_1: for j in 0 to log2_Of_num_of_inputs generate
        G2_2: for i in 0 to num_of_inputs/(2**(j+1)) generate --for first round we want half as many mux's as inputs so add 1 to j to make it num_of_inputs/2
            mux_j_i: mux_nbit_struct 
            port map(
                i_a       => internal(j)(2*i),
                i_b       => internal(j)((2*i)+1),
                i_select  => in_select(log2_Of_num_of_inputs-j),
                o_z        => internal(j+1)(i)
                    );

        end generate;
    end generate;




	o_z <= internal(log2_Of_num_of_inputs+1)(0);



--       G1_build: for i in 0 to 32/2 generate
--           signal inter_carry_1_i : std_logic_vector(0 to data_size);
--
--       end generate;
--
--       G2_build: for i in 0 to (32/2)/2 generate
--           signal inter_carry_2_i : std_logic_vector(0 to data_size);
--
--       end generate;
--
--       G3_build: for i in 0 to (32/2)/2/2 generate
--           signal inter_carry_3_i : std_logic_vector(0 to data_size);
--
--       end generate;
--
--       G4_build: for i in 0 to 32/2/2/2/2 generate
--           signal inter_carry_4_i : std_logic_vector(0 to data_size);
--
--       end generate;
--
--
--       G5_build: for i in 0 to 32/2/2/2/2 generate
--           signal inter_carry_5_i : std_logic_vector(0 to data_size);
--
--       end generate;











        -- We loop through and instantiate and connect N invg modules
 --       GX: for i in 0 to data_size generate
 --           mux_i: mux 
 --               port map(
 --                   in_a       => in_a(i),
 --                   in_b       => in_b(i),
 --                   in_select  => in_select,
 --                   o_z       => o_z(i)
 --                       );
 --       end generate;

  
end mux_nbit_nbitto1_struct_arch;