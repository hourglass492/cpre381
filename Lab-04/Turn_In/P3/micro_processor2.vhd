library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity micro_processor2 is
    -- If you cange n you must remake the decoder function
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
  port(
     
    in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_immedate_value  : in std_logic_vector(0 to 15);
    in_control         : in std_logic_vector(0 to 2);

    i_CLK              : in std_logic;
    i_RST              : in std_logic

	);
	
end micro_processor2;

architecture micro_processor2_arch of micro_processor2 is


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
    signal internal_mem_we	       : std_logic;
    signal internal_addsub_ctl         : std_logic;					-- set to high to let the memory load values
    signal internal_mem_reg_we	       : std_logic;
    signal internal_reg_we	       : std_logic;
    signal nothing	       : std_logic;

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


     internal_mem_we	        <= in_control(0) and not in_control(1) and in_control(2); --ie ctl == 5 for sw
     internal_addsub_ctl        <=  in_control(1) and not (in_control(0) and in_control(2)); 		  --ie be controled by ctl(0) unless doing lw/sw then alwas be 0
     internal_mem_reg_we	<= in_control(0) and in_control(1) and in_control(2);	  --ie ctl ==7
     internal_reg_we	        <= not (in_control(0) and not in_control(1) and in_control(2)); -- ie when ctl != 5
	





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






        
    adder_mux: mux_nbit_struct 
        port map(
                    i_a         => internal_imm,
                    i_b         => internal_rt,
                    i_select    => in_control(0),
                    o_z         => internal_mux    
                );

                


    addSub: add_sub_struct
        port map(
            i_a             => internal_rs,
            i_b             => internal_mux,
            i_select        => internal_addsub_ctl,
            o_sum           => internal_sum,
             o_carry        => nothing-- not useing carry right now
        );


    result_mux: mux_nbit_struct 
        port map(
                    i_a         => internal_read,
                    i_b         => internal_sum,  
                    i_select    => internal_mem_reg_we,
                    o_z         => internal_rd    
                );


    G1:  for j in 22 to 31 generate
        internal_sum_bottom_10(j-22) <= internal_sum(j);
    end generate;


        dmem: mem
            port map(
                    clk	            => i_CLK,
                    addr	    => internal_sum_bottom_10,
                    data	    => internal_rt,
                    we		    => internal_mem_we ,
                    q		    => internal_read
            );







end micro_processor2_arch;