library IEEE;
use IEEE.std_logic_1164.all;

entity mux_nbit_nbitto1_struct is
  generic(data_size : integer := 32);
  generic(num_of_inputs : integer := 32);


  port(
     

    G0: for i in 0 to num_of_inputs generate
        in_data_0_(i)    : in std_logic_vector(0 to data_size)

    end generate;

    in_select        : in std_logic_vector(0 to log2(data_size));
    o_z              : out std_logic_vector(0 to data_size)

	);
	
end mux_nbit_nbitto1_struct;

architecture mux_nbit_nbitto1_struct_arch of mux_nbit_nbitto1_struct is


    -- generate all the internal signals
    -- you need half as many internal carries as inputs from the previous
    -- number of inputs
    G11: for j in 1 to log2(num_of_inputs)+1 generate: -- all of the values for j = 0 are filled out in the input section
        G1: for i in 0 to num_of_inputs/(j**2) generate
            signal in_data_(j)_(i) : std_logic_vector(0 to data_size);

        end generate;
    end generate;

--   G2: for i in 0 to (32/2)/2 generate
--       signal inter_carry_2_i : std_logic_vector(0 to data_size);
--
--   end generate;
--
--   G3: for i in 0 to (32/2)/2/2 generate
--       signal inter_carry_3_i : std_logic_vector(0 to data_size);
--
--   end generate;
--
--   G4: for i in 0 to 32/2/2/2/2 generate
--       signal inter_carry_4_i : std_logic_vector(0 to data_size);
--
--   end generate;
--
--
--   G5: for i in 0 to 32/2/2/2/2 generate
--       signal inter_carry_5_i : std_logic_vector(0 to data_size);
--
--   end generate;



    component mux_nbit_struct
        port(
            i_a             : in std_logic_vector(0 to data_size);
            i_b             : in std_logic_vector(0 to data_size);
            i_select        : in std_logic;
            o_z             : out std_logic_vector(0 to data_size)
            );
    end component;

    begin



    G2_1: for j in 0 to log2(num_of_inputs) generate:
        G2_2: for i in 0 to num_of_inputs/(2**(j+1)) generate --for first round we want half as many mux's as inputs so add 1 to j to make it num_of_inputs/2
            mux_(j)_(i): mux 
            port map(
                in_a       => in_data_(j)_(2*i),
                in_b       => in_data_(j)_((2*i)+1),
                in_select  => in_select(j),
                o_z        => in_data_(j+1)_(i)
                    );

        end generate;
    end generate;

    o_z <= in_data_(log2(num_of_inputs))_0;

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