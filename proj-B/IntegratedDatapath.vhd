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
signal func_select  : std_logic_vector(0 to data_size);
signal internal_reg_we  : std_logic_vector(0 to data_size);



signal ALU_ib                           : std_logic_vector(0 to data_size);
signal ALU_ib                           : std_logic_vector(0 to data_size);
signal ALU_ctl                          : std_logic_vector(0 to data_size);
signal ALU_sum                          : std_logic_vector(0 to data_size);
signal nothingTwo                       : std_logic;    
signal nothing                          : std_logic;
signal zero                             : std_logic;
signal ALU_sum                          : std_logic_vector(0 to data_size);
signal ALU_sum_bottom_10                : std_logic_vector(0 to 9);           
signal internal_mem_we                  : std_logic;     
signal data_read                        : std_logic_vector(0 to data_size);   










        --constants start
            signal high                           :std_logic := '1'  ;
            signal low                            :std_logic  := '0';
        --constants end

        -- register inputs and immidates
            signal internal_rs                 : std_logic_vector(0 to data_size);
            signal internal_rt                 : std_logic_vector(0 to data_size);
            signal register_write_data                 : std_logic_vector(0 to data_size);
            signal internal_imm                : std_logic_vector(0 to data_size);
        -- register inputs and immidates end

        -- binary blob to signals start
            signal instruction                    : std_logic_vector(0 to data_size);
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


        component ALUcontrol
            port(  
                i_instructions          : in std_logic_vector(0 to 5);
                ALUctl_signal           : in std_logic_vector(0 to 4);
        
                ALUOpIn                 : in std_logic_vector(0 to 4)
                );
        end component;




            
        --TODO I don't think I need this
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

   
    -- instruction binary to signals

         rs_select        <= instruction(21 to 25);
        
         rt_select        <= instruction(16 to 20);

        -- if statment to select if instruction bits 20-16 or 15-11
         rd_select        <= instruction(16 to 20) when reg_dst = '0' else
				 instruction(11 to 15);
                                        
        
        

        --instruction bits 15 - 0
         internal_raw_immidates <= instruction(0 to 15);

         func_select <= instruction(0 to 5);


    -- end instruction binary to signals


    extender: extender16bit_flow
        port map(
            i_control    => low,     -- 0 to extend sign, 1 to extend 0's
            i_D          => in_immedate_value,     -- Data input
            o_Q          => internal_imm 
    );



    -- mux to output the rt data
    reg: registerFile_nbit_struct
        port map(
            i_rd               => register_write_data, --value to load
            in_select_rs       => in_select_rs, -- next 3 select the register to pull from for each value
            in_select_rt       => in_select_rt,
            in_select_rd       => in_select_rd,
            i_WE               => internal_reg_we,
            i_CLK              => i_CLK,
            i_RST              => i_RST,
        
        
            o_rt               => internal_rt,
            o_rs               => internal_rs
    );


    ALUmux: mux_nbit_struct 
        port map(
                    i_a         => internal_imm,
                    i_b         => internal_rt,
                    i_select    => ALUsrc,
                    o_z         => ALU_ib    
    );

                
    ALU: FullALU
        port map(
            in_ia             => internal_rs,
            in_ib             => ALU_ib,
            in_ctl       	  => ALU_ctl,
			
            out_data          => ALU_sum,
			out_overflow	  => nothingTwo,
            out_carry         => nothing,-- not useing carry right now
			out_zero		  => zero
    );


    result_mux: mux_nbit_struct 
        port map(
                    i_a         => data_read,
                    i_b         => ALU_sum,  
                    i_select    => memToReg,
                    o_z         => register_write_data    
    );


    G1:  for j in 22 to 31 generate
        ALU_sum_bottom_10(j-22) <= ALU_sum(j);
    end generate;


    dmem: mem
        port map(
                clk	        => i_CLK,
                addr	    => ALU_sum_bottom_10,
                data	    => internal_rt,
                we		    => internal_mem_we ,
                q		    => data_read
    );



    programCounter: pc
        port(  
            i_branch                => branch,
            i_zero                  => zero,
            i_immedate              => instruction(25 to 0),

            o_instruction_number    => pc

    );




    imem: mem
        port map(
                clk	        => i_CLK,
                addr	    => pc,
                data	    => instruction,
                we		    => 0 
    );

    ctl: control
    port(  
        i_instructions          => instruction(31 to 26),


        regDst                  => regDst,
        branch                  => branch,
        memRead                 => memRead,
        memToReg                => memToReg,
        ALUOp                   => ALUOp,
        memWrite                => memWrite,
        ALUSrc                  => ALUSrc,
        RegWrite                => RegWrite
    );


    ALUctl: ALUcontrol
    port(  
        i_instructions          => instruction(5 to 0),
        ALUctl_signal           => ALUOp, ---not sure how large of a signal

        ALUOpIn                 => ALUOpIn --4 bit
    );




end IntegratedDatapath_arch;