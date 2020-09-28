library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

use work.arrayPackage.all;

entity ALU32Bit is
  port(
     
    in_ia              : in std_logic_vector(0 to data_size);
    in_ib              : in std_logic_vector(0 to data_size);
    in_ctl             : in std_logic_vector(0 to 2);


    out_data            : in std_logic_vector(0 to data_size);
    out_overflow        : out std_logic;
    out_carry           : out std_logic;
    out_zero            : out std_logic

	);
	
end ALU32Bit;

architecture ALU32Bit_arch of ALU32Bit is


    signal internal_data	            : std_logic_vector(0 to data_size);
    signal internal_overflow_carry      : std_logic_vector(0 to data_size);
    signal internal_slt_signal          : std_logic_vector(0 to data_size);
    
    signal nothing	                    : std_logic;



    signal ctl_and                        : std_logic;
    signal ctl_or                         : std_logic;
    signal ctl_xor	                      : std_logic;
    signal ctl_nand                       : std_logic;					-- set to high to let the memory load values
    signal ctl_nor	                      : std_logic;
    signal ctl_add	                      : std_logic;
    signal ctl_sub	                      : std_logic;
    signal ctl_slt	                      : std_logic;
	signal ctl_add_sub			          : std_logic;


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


        ctl_and     <= in_ctl(0)     and in_ctl(1)      and in_ctl(2);
        ctl_or      <= in_ctl(0)     and in_ctl(1)      and not in_ctl(2);
        ctl_xor     <= in_ctl(0)     and not in_ctl(1)  and in_ctl(2);
        ctl_nand    <= in_ctl(0)     and not in_ctl(1)  and not in_ctl(2);
        ctl_nor     <= not in_ctl(0) and in_ctl(1)      and in_ctl(2);
        ctl_add     <= not in_ctl(0) and in_ctl(1)      and not in_ctl(2);
        ctl_sub     <= not in_ctl(0) and not in_ctl(1)  and in_ctl(2);
        ctl_slt     <= not in_ctl(0) and not in_ctl(1)  and not in_ctl(2);
    
        

        --This is outside the loop because it needs ctl_sub as it's carry in
        1bitALU_0: ALU1bit 
        port(
       
            in_ia              => in_ia(0),  
            in_ib              => in_ib(0),  
            in_carry           => ctl_sub,
            in_ctl             => in_ctl,
        
        
            out_data            => internal_data(0),
            out_carry           => internal_carry(0)
        
            );




        G1: for j in 1 to data_size generate
            1bitALU_j: ALU1bit 
            port(
        
                in_ia              => in_ia(j),  
                in_ib              => in_ib(j),  
                in_carry           => internal_carry(j-1),
                in_ctl             => in_ctl,
            
            
                out_data            => internal_data(j),
                out_carry           => internal_carry(j)
            
                );
        end generate;



        G1: for j in 0 to data_size-1 generate
            internal_slt_signal(j) <= '0';
        end generate;
        internal_slt_signal(data_size) <= internal_data(data_size;)



        sltMux: mux_nbit_struct 
        port(
    
            i_a             <= internal_data,
            i_b             <= internal_slt_signal,
            i_select        <= ctl_slt,
            o_z             <= out_data
        
            );



        out_overflow <= internal_data(31) xorinternal_carry(31);
        out_zero   <= not (internal_data(0) or  internal_data(1) or  internal_data(2) or  internal_data(3) or  internal_data(4) or  internal_data(5) or  internal_data(6) or  internal_data(7) or  internal_data(8) or  internal_data(9) or  internal_data(10) or  internal_data(11) or  internal_data(12) or  internal_data(13) or  internal_data(14) or  internal_data(15) or  internal_data(16) or  internal_data(17) or  internal_data(18) or  internal_data(19) or  internal_data(20) or  internal_data(21) or  internal_data(22) or  internal_data(23) or  internal_data(24) or  internal_data(25) or  internal_data(26) or  internal_data(27) or  internal_data(28) or  internal_data(29) or  internal_data(30) or  internal_data(31));



end ALU32Bit_arch;