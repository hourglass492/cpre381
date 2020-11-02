library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity FullALU is
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
	
end FullALU;

architecture FullALU_arch of FullALU is



    signal internal_alu_ctl             : std_logic_vector(0 to 2);
    

	--new Signals for final mux to pick between shifter and operations
    signal internal_shiftResult          : std_logic_vector(0 to data_size);
    signal internal_ALUResult          : std_logic_vector(0 to data_size);
	

	
	--shifter signals
	signal ctl_sll						  : std_logic;
	signal ctl_slA						  : std_logic;
	signal ctl_srl						  : std_logic;
	signal ctl_srA						  : std_logic;
	signal ctl_LorR						  : std_logic;
	signal ctl_AorL						  : std_logic;
	
	signal ctl_ALUorShiftSelect						  : std_logic;



component ALU32Bit 
    generic(data_size : integer := 31);
     port(
        
       in_ia              : in std_logic_vector(0 to data_size);
       in_ib              : in std_logic_vector(0 to data_size);
       in_ctl             : in std_logic_vector(0 to 2);
   
   
       out_data            : out std_logic_vector(0 to data_size);
       out_overflow        : out std_logic;
       out_carry           : out std_logic;
       out_zero            : out std_logic
   
       );
       
end component;




component bsLR
      port (LorR    : in  std_logic; -- '1' for left, '0' for right
            LorA    : in  std_logic; -- '1' for arithmetic, '0' for logical
            i_s     : in  std_logic_vector(4 downto 0);  -- shift count
            i_a     : in  std_logic_vector (31 downto 0);
            o_a     : out std_logic_vector (31 downto 0) );
end component;


component mux_nbit_struct
    generic(N : integer := 31);
    port(
       
      i_a             : in std_logic_vector(0 to N);
      i_b             : in std_logic_vector(0 to N);
      i_select        : in std_logic;
      o_z             : out std_logic_vector(0 to N)
  
      );
      
end component;



    begin

		
		--shift operation controls
		ctl_sll     <= not in_ctl(0)	 and in_ctl(1)     and in_ctl(2)      and in_ctl(3) 	;
        ctl_slA     <= not in_ctl(0)	 and in_ctl(1)     and in_ctl(2)      and not in_ctl(3)	;
        ctl_srl     <= not in_ctl(0)	 and in_ctl(1)     and not in_ctl(2)  and in_ctl(3)		;
        ctl_srA     <= not in_ctl(0)	 and in_ctl(1)     and not in_ctl(2)  and not in_ctl(3)	;


        ctl_ALUorShiftSelect <= in_ctl(0);




		ctl_LorR	<= ctl_sll or ctl_slA;
		ctl_AorL	<= ctl_slA or ctl_srA;

        
        ctl_ALUorShiftSelect <= in_ctl(0);


        G1: for j in 0 to 2 generate
        internal_alu_ctl(j) <= in_ctl(j+1);
        end generate;



        alu: ALU32Bit 
             port map(
               in_ia              => in_ia,
               in_ib              => in_ib,
               in_ctl             => in_ctl(1 to 3),
           
           
               out_data            => internal_ALUResult,
               out_overflow        => out_overflow,
               out_carry           => out_carry ,
               out_zero            => out_zero  
               );
               



--barrel Shifter component of ALU
        BarrelShifter: bsLR 
        port map(
    
            LorR             => ctl_LorR,
            LorA             => ctl_AorL,
            i_s       		 => in_ib(0 to 4),
            i_a              => in_ia,
			o_a		     => internal_shiftResult
        
            );


        finalMux: mux_nbit_struct 
        port map(
    
            i_a             => internal_ALUResult,
            i_b             => internal_shiftResult,
            i_select        => ctl_ALUorShiftSelect,
            o_z             => out_data
        
            );




end FullALU_arch;