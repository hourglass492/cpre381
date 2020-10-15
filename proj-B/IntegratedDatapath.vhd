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


    signal internal_rs                 : std_logic_vector(0 to N);
    signal internal_rt                 : std_logic_vector(0 to N);
    signal internal_rd                 : std_logic_vector(0 to N);
    signal internal_imm                : std_logic_vector(0 to N);
    signal internal_mux                : std_logic_vector(0 to N);
    signal internal_sum                : std_logic_vector(0 to N);
    signal internal_sum_bottom_10      : std_logic_vector(0 to 9);
    signal internal_read               : std_logic_vector(0 to N);
    signal high                        : std_logic := '1';
    signal low                         : std_logic := '0';
    signal internal_mem_we	            : std_logic;
    signal internal_alu_ctl             : std_logic;					-- set to high to let the memory load values
    signal internal_mem_reg_we_mux_ctl	        : std_logic;
    signal internal_reg_we	            : std_logic;
    signal internal_imm_select_ctl        : std_logic;

    --memory signals

    signal ctl_lw                         : std_logic;
    signal ctl_sw                         : std_logic;


    --Control Signals
    signal ctl_and                        : std_logic;
    signal ctl_or                         : std_logic;
    signal ctl_xor	                      : std_logic;
    signal ctl_nand                       : std_logic;					-- set to high to let the memory load values
    signal ctl_nor	                      : std_logic;
    signal ctl_add	                      : std_logic;
    signal ctl_sub	                      : std_logic;
    signal ctl_addi	                      : std_logic;
    signal ctl_subi	                      : std_logic;
    signal ctl_slt	                      : std_logic;
	signal ctl_add_sub			          : std_logic;
	signal ctl_adder_carry_in		      :std_logic;
	
	--shifter signals
	signal ctl_sll						  : std_logic;
	signal ctl_slA						  : std_logic;
	signal ctl_srl						  : std_logic;
	signal ctl_srA						  : std_logic;



    signal nothing	                    : std_logic;
	signal nothingTwo	                : std_logic;
	signal nothingThree	                : std_logic;

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
		



component add_sub_struct
  generic(N : integer := 31);
  port(
     


    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select         : in std_logic;
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




    begin


        --Memory operations

        ctl_lw <= not in_ctl(0)	 and not in_ctl(1)     and in_ctl(2)      and in_ctl(3) 	;
        ctl_sw <= not in_ctl(0)	 and not in_ctl(1)     and in_ctl(2)      and in_ctl(3) 	;


        -- ALU operations

        ctl_addi     <= not in_ctl(0)	 and not in_ctl(1) and in_ctl(2)      and not in_ctl(3)	;
        ctl_subi     <= not in_ctl(0)	 and not in_ctl(1) and not in_ctl(2)  and in_ctl(3)		;


        ctl_and     <= in_ctl(0)	 and in_ctl(1)     and in_ctl(2)      and in_ctl(3) 	;
        ctl_or      <= in_ctl(0)	 and in_ctl(1)     and in_ctl(2)      and not in_ctl(3)	;
        ctl_xor     <= in_ctl(0)	 and in_ctl(1)     and not in_ctl(2)  and in_ctl(3)		;
        ctl_nand    <= in_ctl(0)	 and in_ctl(1)     and not in_ctl(2)  and not in_ctl(3)	;
        ctl_nor     <= in_ctl(0)	 and not in_ctl(1) and in_ctl(2)      and in_ctl(3)		;
        ctl_add     <= in_ctl(0)	 and not in_ctl(1) and in_ctl(2)      and not in_ctl(3)	;
        ctl_sub     <= in_ctl(0)	 and not in_ctl(1) and not in_ctl(2)  and in_ctl(3)		;
        ctl_slt     <= in_ctl(0)	 and not in_ctl(1) and not in_ctl(2)  and not in_ctl(3);
		
		--shift operation controls
		ctl_sll     <= not in_ctl(0)	 and in_ctl(1)     and in_ctl(2)      and in_ctl(3) 	;
        ctl_slA     <= not in_ctl(0)	 and in_ctl(1)     and in_ctl(2)      and not in_ctl(3)	;
        ctl_srl     <= not in_ctl(0)	 and in_ctl(1)     and not in_ctl(2)  and in_ctl(3)		;
        ctl_srA     <= not in_ctl(0)	 and in_ctl(1)     and not in_ctl(2)  and not in_ctl(3)	;


        --TODO we may need immideate values for all the logical and lw/sw operations



        internal_mem_we	                <= ctl_sw;          --we should write data to memory only on a write word
        internal_mem_reg_we_mux_ctl	    <= ctl_lw;          --only taking data from memory to write to register on lw
        internal_reg_we	                <= not (ctl_sw);    -- The only time we don't write to the register file is on a store word
        internal_imm_select_ctl         <= ctl_srA or ctl_srl or ctl_slA or ctl_sll or ctl_subi or ctl_addi;





extender: extender16bit_flow
port map(
	i_control       => low,     -- 0 to extend sign, 1 to extend 0's
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







end IntegratedDatapath_arch;