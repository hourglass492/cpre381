library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package arrayPackage is
	constant data_size : integer := 31;  --bits wide
	constant num_of_inputs    : integer := 31; --bits wide
	constant log2_Of_num_of_inputs : integer := 4;
	type inputVectors is array(0 to num_of_inputs) of std_logic_vector (0 to data_size);
	type internalCarry is array(0 to log2_Of_num_of_inputs+1) of inputVectors;
end package arrayPackage;

