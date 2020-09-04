library IEEE;
use IEEE.std_logic_1164.all;

entity registerFile_nbit_struct is
    -- If you cange n you must remake the decoder function
  generic(N : integer := 32);
  port(
     


    i_rd               : in std_logic_vector(0 to N);
    in_select_rs       : in std_logic_vector(0 to 5);
    in_select_rt       : in std_logic_vector(0 to 5);
    in_select_rd       : in std_logic_vector(0 to 5);
    i_WE               : in std_logic;
    i_CLK              : in std_logic;
    i_RST              : in std_logic;


    o_rt               : out std_logic_vector(0 to N);
    o_rs               : in std_logic_vector(0 to N);
    o_carry            : out std_logic

	);
	
end registerFile_nbit_struct;

architecture registerFile_nbit_struct_arch of registerFile_nbit_struct is

        signal inter_select  : std_logic_vector(0 to N);

        G00: for i in 0 to N generate:
            signal inter_carry_(i)      : std_logic_vector(0 to N);
        end generate;




        component decoder5to32_flow
            port(
                i_data        : in std_logic_vector(0 to 5);     
                o_data        : in std_logic_vector(0 to 32)
                );
        end component;


        component mux_nbit_nbitto1_struct
            port(
                G0: for i in 0 to N generate
                    in_data_0_(i)    : in std_logic_vector(0 to N)
            
                end generate;
            
                in_select        : in std_logic_vector(0 to log2(N));
                o_z              : out std_logic_vector(0 to N)
                );
        end component;


        component register_nbit_struct
            port(
                i_CLK             : in std_logic;
                i_RST             : out std_logic;
                i_WE              : in std_logic;
                i_D               : in std_logic_vector(0 to N);   
            
                o_Q               : out std_logic_vector(0 to N)
                );
        end component;

    begin

        
    -- Everything but this circuit can scale up YOU MUST REBUILD THIS TO CHANGE N
    inverter: decoder5to32_flow 
        port map(
                    i_data   => in_select_rd,
                    o_z      => inter_select     
                );




    --create all of registers
    G1: for i in 0 to N generate
            register_(i): register_nbit_struct
            port map(


                i_CLK             => i_CLK;
                i_RST             => i_RST;
                i_WE              => inter_select(i) and i_WE; --only write when global write is on and this register selected 
                i_D               => i_rd;   
            
                o_Q               => inter_carry_(i)

            )
    end generate;

        

    -- mux to output the rt data
    mux_rt: mux_nbit_nbitto1_struct
    port map(

            --get all the inputs from the registers
            G2: for i in 0 to N generate
                in_data_0_(i)    => inter_carry_(i);
        
            end generate;
        
            in_select            => in_select_rt;
            o_z                  => o_rt
    );




    -- mux to output the rs data
    mux_rs: mux_nbit_nbitto1_struct
    port map(

            --get all the inputs from the registers
            G2: for i in 0 to N generate
                in_data_0_(i)    => inter_carry_(i);
        
            end generate;
        
            in_select            => in_select_rs;
            o_z                  => o_rs
    );


        






end registerFile_nbit_struct_arch;