library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity IntegratedDatapath is
    -- If you cange n you must remake the decoder function
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
  port(
     
    in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_immedate_value  : in std_logic_vector(0 to 15);
    in_ctl             : in std_logic_vector(0 to 3);

    i_CLK              : in std_logic;
    i_RST              : in std_logic

	);
	
end IntegratedDatapath;

architecture IntegratedDatapath_arch of IntegratedDatapath is

    --signals


        --constants start
            signal high                := 1            :std_logic;
            signal low                 := 0            :std_logic;
        --constants end

        -- register inputs and immidates
            signal internal_rs                 : std_logic_vector(0 to data_size);
            signal internal_rt                 : std_logic_vector(0 to data_size);
            signal internal_rd                 : std_logic_vector(0 to data_size);
            signal internal_imm                : std_logic_vector(0 to data_size);
        -- register inputs and immidates end

        -- binary blob to signals start
            signal rs_select                   : std_logic_vector(0 to log2_Of_num_of_inputs);
            signal rt_select                   : std_logic_vector(0 to log2_Of_num_of_inputs);
            signal rd_select                   : std_logic_vector(0 to log2_Of_num_of_inputs);
            signal internal_raw_immidates      : std_logic_vector(0 to 15);
        -- binary blob to signals end

        --ctl signals start
            signal regDst                              : std_logic;
            signal branch                              : std_logic;
            signal memRead                             : std_logic;
            signal memToReg                            : std_logic;
            signal ALUOp                               : std_logic_vector(0 to 4);
            signal memWrite                            : std_logic;
            signal ALUSrc                              : std_logic;
            signal regWrite                            : std_logic;
        --ctl signals end 

        -- buses start
            signal ALU2ndInput                         : std_logic_vector(0 to data_size);
            signal programCounter                      : std_logic_vector(0 to data_size);
            signal ALUOutput                           : std_logic_vector(0 to data_size);
            signal memoryOutput                        : std_logic_vector(0 to data_size);
        -- buses end


    
    -- end signal
    

    --components
        component registerFile_nbit_struct
            port(
                i_rd                       : in std_logic_vector(0 to N);
                in_select_rs               : in std_logic_vector(0 to log2_Of_num_of_inputs);
                in_select_rt               : in std_logic_vector(0 to log2_Of_num_of_inputs);
                in_select_rd               : in std_logic_vector(0 to log2_Of_num_of_inputs);
                i_WE                       : in std_logic;
                i_CLK                      : in std_logic;
                i_RST                      : in std_logic;
            
            
                o_rt                       : out std_logic_vector(0 to N);
                o_rs                       : out std_logic_vector(0 to N)


                );
        end component;
            
        
        component adder_nbit_struct
            generic(N : integer := 31);
            port(
                


                i_a             : in std_logic_vector(0 to N);
                i_b             : in std_logic_vector(0 to N);
                i_carry         : in std_logic;
                o_sum           : out std_logic_vector(0 to N);
                o_carry         : out std_logic

                );
            
        end component;


        component FullALU
            generic(data_size : integer := 31);
            port(
                
                in_ia              : in std_logic_vector(0 to data_size);
                in_ib              : in std_logic_vector(0 to data_size);
                in_ctl             : in std_logic_vector(0 to 3);


                out_data            : out std_logic_vector(0 to data_size);
                out_overflow        : out std_logic;
                out_carry           : out std_logic;
                out_zero            : out std_logic

                );
            
        end component;



        component mux_nbit_struct
            port(
                i_a             : in std_logic_vector(0 to N);
                i_b             : in std_logic_vector(0 to N);
                i_select        : in std_logic;
                o_z             : out std_logic_vector(0 to N)


                );
        end component;

        component mem
            port(  
                signal clk	    : in std_logic;
                signal addr	    : in std_logic_vector(9 downto 0);
                signal data	    : in std_logic_vector(N downto 0);
                signal we		: in std_logic;
                signal q		: out std_logic_vector(N downto 0)

            );
        end component;

        component extender16bit_flow
            port(  
            i_control    : in std_logic;     -- 0 to extend sign, 1 to extend 0's
            i_D          : in std_logic_vector( 0 to 15);     -- Data input
            o_Q          : out std_logic_vector( 0 to 31)       -- Data  output

            );
        end component;

        component control
            port(  
                i_instructions          : in std_logic_vector(0 to 5);


                regDst                  : out std_logic;
                branch                  : out std_logic;
                memRead                 : out std_logic;
                memToReg                : out std_logic;
                ALUOp                   : out std_logic_vector(0 to 4);
                memWrite                : out std_logic;
                ALUSrc                  : out std_logic;
                RegWrite                : out std_logic

            );
        end component;

        component pc
            port(  
                i_branch                : in std_logic;
                i_zero                  : in std_logic;
                i_immedate              : in std_logic_vector(0 to 31);




                o_instruction_number    : out std_logic_vector(0 to 31)

            );
        end component;

    --end components




    begin

    -- TODO need to assign these signals
    -- instruction binary to signals

        signal rs_select        <= ;
        signal rt_select        <= ;

        -- if statment to select if instruction bits 20-16 or 15-11
        signal rd_select        <= ;

        --instruction bits 15 - 0
        signal internal_raw_immidates <= 


    -- end instruction binary to signals


    extender: extender16bit_flow
        port map(
            i_control    => low,     -- 0 to extend sign, 1 to extend 0's
            i_D          => in_immedate_value,     -- Data input
            o_Q          => internal_imm 
    );



    -- mux to output the rt data
    register_file: registerFile_nbit_struct
        port map(
            i_rd               => internal_rd, --value to load
            in_select_rs       => in_select_rs, -- next 3 select the register to pull from for each value
            in_select_rt       => in_select_rt,
            in_select_rd       => in_select_rd,
            i_WE               => internal_reg_we,
            i_CLK              => i_CLK,
            i_RST              => i_RST,
        
        
            o_rt               => internal_rt,
            o_rs               => internal_rs
    );


    immedate_mux: mux_nbit_struct 
        port map(
                    i_a         => internal_imm,
                    i_b         => internal_rt,
                    i_select    => internal_imm_select_ctl,
                    o_z         => internal_mux    
    );

                
    ALU: FullALU
        port map(
            in_ia             => internal_rs,
            in_ib             => internal_mux,
            in_ctl       	  => in_ctl,
			
            out_data          => internal_sum,
			out_overflow	  => nothingTwo,
            out_carry         => nothing,-- not useing carry right now
			out_zero		  => nothingThree
    );


    result_mux: mux_nbit_struct 
        port map(
                    i_a         => internal_read,
                    i_b         => internal_sum,  
                    i_select    => internal_mem_reg_we_mux_ctl,
                    o_z         => internal_rd    
    );


    G1:  for j in 22 to 31 generate
        internal_sum_bottom_10(j-22) <= internal_sum(j);
    end generate;









    dmem: mem
        port map(
                clk	        => i_CLK,
                addr	    => internal_sum_bottom_10,
                data	    => internal_rt,
                we		    => internal_mem_we ,
                q		    => internal_read
    );

    imem: mem
        port map(
                clk	        => i_CLK,
                addr	    => ,
                data	    => instruction,
                we		    => 0 
    );






end IntegratedDatapath_arch;