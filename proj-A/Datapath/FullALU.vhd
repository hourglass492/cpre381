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


    signal internal_data	            : std_logic_vector(0 to data_size);
    signal internal_carry     			: std_logic_vector(0 to data_size);
    signal internal_slt_signal          : std_logic_vector(0 to data_size);
	
	--new Signals for final mux to pick between shifter and operations
    signal internal_OPResult          : std_logic_vector(0 to data_size);
	signal internal_shiftResult          : std_logic_vector(0 to data_size);
	
    signal nothing	                    : std_logic;



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
	signal ctl_LorR						  : std_logic;
	signal ctl_AorL						  : std_logic;
	
	signal ctl_ALUorShiftSelect						  : std_logic;

component add_sub_struct
  generic(N : integer := data_size);
  port(
     
    i_a             : in std_logic_vector(0 to N);
    i_b             : in std_logic_vector(0 to N);
    i_select         : in std_logic;
    o_sum           : out std_logic_vector(0 to N);
    o_carry         : out std_logic

	);
	
end component;

component ALU1bit 
    generic(numOfOperations : integer := 7);
  
    port(
       
      in_ia              : in std_logic;
      in_ib              : in std_logic;
      in_carry              : in std_logic;
      in_ctl             : in std_logic_vector(0 to 2);
  
  
      out_data            : out std_logic;
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







		ctl_LorR	<= ctl_sll or ctl_slA;
		ctl_AorL	<= ctl_slA or ctl_srA;
	ctl_adder_carry_in <= ctl_sub or ctl_slt;
	
    ctl_ALUorShiftSelect <= in_ctl(0);
        

        --This is outside the loop because it needs ctl_sub as it's carry in
	internal_carry(0) <=  ctl_sub;
        ALU1bit_31: ALU1bit 
        port map(
       
            in_ia              => in_ia(31),  
            in_ib              => in_ib(31),  
            in_carry           => ctl_adder_carry_in,
            in_ctl             => in_ctl(0 to 2),
        
        
            out_data            => internal_data(31),
            out_carry           => internal_carry(31)
        
            );




        G1: for j in 0 to data_size-1 generate
            ALU1bit_j: ALU1bit 
            port map(
        
                in_ia              => in_ia(j),  
                in_ib              => in_ib(j),  
                in_carry           => internal_carry(j+1),
                in_ctl             => in_ctl(0 to 2),
            
            
                out_data            => internal_data(j),
                out_carry           => internal_carry(j)
            
                );
        end generate;



        G2: for j in 0 to data_size-1 generate
            internal_slt_signal(j) <= '0';
        end generate;
        internal_slt_signal(data_size) <= internal_data(data_size);


--barrel Shifter component of ALU
        BarrelShifter: bsLR 
        port map(
    
            LorR             => ctl_LorR,
            LorA             => ctl_AorL,
            i_s       		 => in_ib(0 to 4),
            i_a              => in_ia,
			o_a				 => internal_shiftResult
        
            );

        sltMux: mux_nbit_struct 
        port map(
    
            i_a             => internal_slt_signal,
            i_b             => internal_data,
            i_select        => ctl_slt,
            o_z             => internal_OPResult
        
            );

        finalMux: mux_nbit_struct 
        port map(
    
            i_a             => internal_OPResult,
            i_b             => internal_shiftResult,
            i_select        => ctl_ALUorShiftSelect,
            o_z             => out_data
        
            );

        out_overflow <= internal_data(31) xor internal_carry(31);
        out_zero   <= not (internal_data(0) or  internal_data(1) or  internal_data(2) or  internal_data(3) or  internal_data(4) or  internal_data(5) or  internal_data(6) or  internal_data(7) or  internal_data(8) or  internal_data(9) or  internal_data(10) or  internal_data(11) or  internal_data(12) or  internal_data(13) or  internal_data(14) or  internal_data(15) or  internal_data(16) or  internal_data(17) or  internal_data(18) or  internal_data(19) or  internal_data(20) or  internal_data(21) or  internal_data(22) or  internal_data(23) or  internal_data(24) or  internal_data(25) or  internal_data(26) or  internal_data(27) or  internal_data(28) or  internal_data(29) or  internal_data(30) or  internal_data(31));



end FullALU_arch;