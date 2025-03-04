library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity registerFile_nbit_struct is
    -- If you cange n you must remake the decoder function
  generic(N : integer := 31);
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
	
end registerFile_nbit_struct;

architecture registerFile_nbit_struct_arch of registerFile_nbit_struct is

        signal inter_select  : std_logic_vector(0 to N);
	signal write_enable_vector : std_logic_vector(0 to N);

        --G00: for i in 0 to N generate
          signal inter_carry      : inputVectors;
        --end generate;
	
	signal ground : std_logic := '0' ;

	component andg2
		port(
			i_A          : in std_logic;
       			i_B          : in std_logic;
       			o_F          : out std_logic
			);
	end component;
		



        component decoder5to32_flow
            port(
                i_data        : in std_logic_vector(0 to 4);     
                o_data        : out std_logic_vector(0 to 31)
                );
        end component;


        component mux_nbit_nbitto1_struct
            port(
--                G0: for i in 0 to N generate
                    in_data_0    : in inputVectors;
            
--                end generate;
            
                in_select        : in std_logic_vector(0 to log2_Of_num_of_inputs);
                o_z              : out std_logic_vector(0 to N)


                );
        end component;


        component register_nbit_struct
            port(
                i_CLK             : in std_logic;
                i_RST             : in std_logic;
                i_WE              : in std_logic;
                i_D               : in std_logic_vector(0 to N);   
            
                o_Q               : out std_logic_vector(0 to N)
                );
        end component;

    begin

        
    -- Everything but this circuit can scale up YOU MUST REBUILD THIS TO CHANGE N
    inverter: decoder5to32_flow 
        port map(
                    i_data      => in_select_rd,
                    o_data      => inter_select     
                );



    G1: for j in 0 to N generate
            and_j: andg2
            port map(


			i_A          => inter_select(j),
       			i_B          => i_WE,
       			o_F          => write_enable_vector(j)

            );
    end generate;



    G00: for j in 0 to N generate
	inter_carry(0)(j) <= ground;
    end generate;





    --create all of registers
    G0: for j in 1 to N generate
            register_j: register_nbit_struct
            port map(


                i_CLK             => i_CLK,
                i_RST             => i_RST,
                i_WE              => write_enable_vector(j), --only write when global write is on and this register selected 
                i_D               => i_rd,   
            
                o_Q               => inter_carry(j)

            );
    end generate;

        

    -- mux to output the rt data
    mux_rt: mux_nbit_nbitto1_struct
    port map(

            --get all the inputs from the registers
 --           G2: for i in 0 to N generate
                in_data_0    => inter_carry,
        
 --           end generate;
        
            in_select            => in_select_rt,
            o_z                  => o_rt
    );




    -- mux to output the rs data
    mux_rs: mux_nbit_nbitto1_struct
    port map(


                in_data_0    => inter_carry,
        

            in_select            => in_select_rs,
            o_z                  => o_rs
    );


        






end registerFile_nbit_struct_arch;