library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;



entity pc is 
    port(  
        i_zero                  : in std_logic;
        i_rst                   : in std_logic;
        i_immedate              : in std_logic_vector(0 to 31);
        i_CLK                   : in std_logic;
		beq                     : in std_logic;
		bne                     : in std_logic;
		jump                    : in std_logic;
		
		
        o_instruction_number    : out std_logic_vector(0 to 31)


    );

end pc;



architecture pc_arch of pc is

    signal next_pc           : std_logic_vector(0 to data_size);
    signal add_4             : std_logic_vector(0 to data_size);
    signal add_input         : std_logic_vector(0 to data_size);
    signal branch_and_zero     : std_logic;
    signal SetToDefaultVal     : std_logic;
    signal shifted_input     : std_logic_vector(0 to data_size);
    signal last_pc           : std_logic_vector(0 to data_size);

    component register_nbit_struct
        port(
            i_CLK             : in std_logic;
            i_RST             : in std_logic;
            i_WE              : in std_logic;
            i_D               : in std_logic_vector(0 to data_size);  
            i_Default         : in std_logic_vector(0 to data_size);  
				
        
            o_Q               : out std_logic_vector(0 to data_size)
            );
    end component;


    component adder_nbit_struct
        port(
           
            i_a             : in std_logic_vector(0 to data_size);
            i_b             : in std_logic_vector(0 to data_size);
            i_carry         : in std_logic;
            o_sum           : out std_logic_vector(0 to data_size);
            o_carry         : out std_logic
      
          );
          
    end component;



    component mux_nbit_struct
        port(
           
          i_a             : in std_logic_vector(0 to data_size);
          i_b             : in std_logic_vector(0 to data_size);
          i_select        : in std_logic;
          o_z             : out std_logic_vector(0 to data_size)
      
          );
          
    end component;


begin










    reg: register_nbit_struct
        port map (
            i_CLK             => i_CLK, 
            i_RST             => i_RST,
            i_WE              => '1',
            i_D               => next_pc,
			i_Default		  => x"00400000",		
        
            o_Q               => last_pc
            );




    

	o_instruction_number <= last_pc;



    --TODO we need to fix this for control signals to let it branch if not zero
    branch_and_zero <= ((i_zero and beq) or (not i_zero and bne)); -- xor b/c it 
	
	
	next_pc <= i_immedate when jump = '1'
	
		else add_input when branch_and_zero = '1'
		
		else x"00400000" when i_RST = '1'
	
		else add_4;
		
	


	--This was done in the processure now
     --TODO I need to figure out how to shift this
	-- shifted_input(31) <= '0';
	-- shifted_input(30) <= '0';
	    G1:  for j in 0 to 31 generate
        		shifted_input(31-j) <= i_immedate(j);
    		end generate;
--	    G2:  for j in 26 to 31 generate
 --       		shifted_input(j) <= last_pc    (j);
 --   		end generate;
    
 


    -- add the input and the shifted value 
    immedate_adder: adder_nbit_struct 
        port map(
            i_a       => add_4,
            i_b       => i_immedate,
		i_carry		=> '0',

            o_sum       => add_input
    );


    -- add the input and the shifted value
    -- TODO does the add 4 immideate value work 
    four_adder: adder_nbit_struct 
        port map(
            i_a       => last_pc       ,
            i_b       => X"00000004",
		    i_carry		=> '0',

            o_sum       => add_4
    );








end pc_arch;









