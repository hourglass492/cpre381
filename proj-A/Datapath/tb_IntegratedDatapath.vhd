
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_IntegratedDatapath is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
end tb_IntegratedDatapath;

architecture behavior of tb_IntegratedDatapath is

  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  -- Temporary signals to connect to the micro_processor2 component.
  signal i_CLK, i_RST : std_logic;
  signal rd_s : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal  rs_s : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal rt_s : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal ctl :  std_logic_vector(0 to 3);
  signal in_immedate_value  : std_logic_vector(0 to 15);

  component IntegratedDatapath
    port(  
    in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    in_immedate_value  : in std_logic_vector(0 to 15);
    in_ctl             : in std_logic_vector(0 to 3);

    i_CLK              : in std_logic;
    i_RST              : in std_logic

    );
  end component;

  

begin

  thing_im_testing: IntegratedDatapath 
  port map(
        
            in_select_rd       => rd_s,
            in_select_rs       => rs_s,
            in_select_rt       => rt_s,


            in_immedate_value  => in_immedate_value,
            in_ctl       	=> ctl,

			
            i_CLK              => i_CLK,
            i_RST              => i_RST

           );

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    i_CLK <= '0';
    wait for gCLK_HPER;
    i_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin

i_RST <= '1';


wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;


i_RST <= '0';


wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;

--addi, $25, $25, $0, 0
-- addi 0 to register $0 and store in $25

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"0000";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $26, $26, $0, 256
-- addi 256 to register $0 and store in $26

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"0100";
		 rd_s <= "11010";
wait for cCLK_PER;


--lw, $1,	0($25)
-- load 0 plus $25 from memory into $1

		ctl <= "0000";
		 rd_s <= "00001";
		 rs_s <= "11001";
		 in_immedate_value <= X"0000";
wait for cCLK_PER;


--lw, $2,	4($25)
-- load 4 plus $25 from memory into $2

		ctl <= "0000";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0001";
wait for cCLK_PER;


--add, $1, $1, $2
--add  $1 and $2 and store in $1

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	0($26)
-- store $1 at memory location $26 plus 0

		ctl <= "1100";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0000";
wait for cCLK_PER;


--lw, $2,	8($25)
-- load 8 plus $25 from memory into $2

		ctl <= "0000";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0002";
wait for cCLK_PER;


--add, $1, $1, $2
--add  $1 and $2 and store in $1

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	4($26)
-- store $1 at memory location $26 plus 4

		ctl <= "1100";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0001";
wait for cCLK_PER;


--lw, $2,	12($25)
-- load 12 plus $25 from memory into $2

		ctl <= "0000";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0003";
wait for cCLK_PER;


--add, $1, $1, $2
--add  $1 and $2 and store in $1

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	8($26)
-- store $1 at memory location $26 plus 8

		ctl <= "1100";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0002";
wait for cCLK_PER;


--lw, $2,	16($25)
-- load 16 plus $25 from memory into $2

		ctl <= "0000";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0004";
wait for cCLK_PER;


--add, $1, $1, $2
--add  $1 and $2 and store in $1

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	12($26)
-- store $1 at memory location $26 plus 12

		ctl <= "1100";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0003";
wait for cCLK_PER;


--lw, $2,	20($25)
-- load 20 plus $25 from memory into $2

		ctl <= "0000";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0005";
wait for cCLK_PER;


--add, $1, $1, $2
--add  $1 and $2 and store in $1

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	16($26)
-- store $1 at memory location $26 plus 16

		ctl <= "1100";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0004";
wait for cCLK_PER;


--lw, $2,	24($25)
-- load 24 plus $25 from memory into $2

		ctl <= "0000";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0006";
wait for cCLK_PER;


--add, $1, $1, $2
--add  $1 and $2 and store in $1

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--addi, $27, $26, 512
-- addi 512 to register $26 and store in $27

		ctl <= "0100";
		 rs_s <= "11010";
		 in_immedate_value <=X"0200";
		 rd_s <= "11011";
wait for cCLK_PER;


--sw, $1,	-4($27)
-- store $1 at memory location $27 plus -4

		ctl <= "1100";
		 rt_s <= "00001";
		 rs_s <= "11011";
		 in_immedate_value <=X"ffff";
		 
wait for cCLK_PER;

-----------------------LAB 4 ENDS HERE------------------------------


-----------------------NEW ALU FUNC TESTS---------------------------

--addi, $1, $0, 15
-- sets register 1 to 15

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"000f";
		 rd_s <= "00001";
wait for cCLK_PER;

--subbi, $2, $1, 7
-- subtracts 7 from reg 1 and stores in reg 2

		ctl <= "1000";
		 rs_s <= "00001";
		 in_immedate_value <=X"0007";
		 rd_s <= "00010";
wait for cCLK_PER;

--subbi, $3, $2, 5
-- subtracts 5 from reg 2 and stores in reg 3

		ctl <= "1000";
		 rs_s <= "00010";
		 in_immedate_value <=X"0005";
		 rd_s <= "00011";
wait for cCLK_PER;

--sla, $3, $3, 1
-- shifts value left in reg 3 by 1 arithmetically

		ctl <= "0010";
		 rs_s <= "00011";
		 in_immedate_value <=X"0001";
		 rd_s <= "00011";
wait for cCLK_PER;

--sla, $3, $3, 2
-- shifts value left in reg 3 by 2 arithmetically

		ctl <= "0010";
		 rs_s <= "00011";
		 in_immedate_value <=X"0002";
		 rd_s <= "00011";
wait for cCLK_PER;

--sll, $3, $3, 1
-- shifts value left in reg 3 by 1 logically

		ctl <= "1110";
		 rs_s <= "00011";
		 in_immedate_value <=X"0001";
		 rd_s <= "00011";
wait for cCLK_PER;

--sll, $3, $3, 2
-- shifts value left in reg 3 by 2 logically

		ctl <= "1110";
		 rs_s <= "00011";
		 in_immedate_value <=X"0002";
		 rd_s <= "00011";
wait for cCLK_PER;

--srl, $3, $3, 2
-- shifts value right in reg 3 by 2 logically

		ctl <= "1010";
		 rs_s <= "00011";
		 in_immedate_value <=X"0002";
		 rd_s <= "00011";
wait for cCLK_PER;

--srl, $3, $3, 1
-- shifts value right in reg 3 by 1 logically

		ctl <= "1010";
		 rs_s <= "00011";
		 in_immedate_value <=X"0001";
		 rd_s <= "00011";
wait for cCLK_PER;

--srA, $3, $3, 2
-- shifts value right in reg 3 by 2 arithmetically

		ctl <= "1010";
		 rs_s <= "00011";
		 in_immedate_value <=X"0002";
		 rd_s <= "00011";
wait for cCLK_PER;

--srA, $3, $3, 1
-- shifts value right in reg 3 by 4 arithmetically

		ctl <= "1010";
		 rs_s <= "00011";
		 in_immedate_value <=X"0004";
		 rd_s <= "00011";
wait for cCLK_PER;

--slt, $3, $1, $2
-- sets reg 3 to 1 if reg 1 is less than reg 2

		ctl <= "0001";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00011";
wait for cCLK_PER;

--slt, $3, $2, $1
-- sets reg 3 to 1 if reg 2 is less than reg 1

		ctl <= "0001";
		 rs_s <= "00010";
		 rt_s <= "00001";
		 rd_s <= "00011";
wait for cCLK_PER;

--sub, $3, $1, $0
-- subtracts reg 0 from reg 1 and stores in reg 3

		ctl <= "1001";
		 rs_s <= "00001";
		 rt_s <= "00000";
		 rd_s <= "00011";
wait for cCLK_PER;

--sub, $3, $1, $2
-- subtracts reg 2 from reg 1 and stores in reg 3

		ctl <= "1001";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00011";
wait for cCLK_PER;

--nor $3, $1, $0
-- nors the values in regs 1 and 0 then stores result in reg 3

		ctl <= "1101";
		 rs_s <= "00001";
		 rt_s <= "00000";
		 rd_s <= "00011";
wait for cCLK_PER;

--nor $3, $1, $3
-- nors the values in regs 1 and 3 then stores result in reg 3

		ctl <= "1101";
		 rs_s <= "00001";
		 rt_s <= "00011";
		 rd_s <= "00011";
wait for cCLK_PER;

--nand $3, $1, $0
-- nands the values in regs 1 and 0 then stores result in reg 3

		ctl <= "0011";
		 rs_s <= "00001";
		 rt_s <= "00000";
		 rd_s <= "00011";
wait for cCLK_PER;

--nand $3, $1, $3
-- nands the values in regs 1 and 3 then stores result in reg 3

		ctl <= "0011";
		 rs_s <= "00001";
		 rt_s <= "00011";
		 rd_s <= "00011";
wait for cCLK_PER;

--xor $3, $1, $0
-- xors the values in regs 1 and 0 then stores result in reg 3

		ctl <= "1011";
		 rs_s <= "00001";
		 rt_s <= "00000";
		 rd_s <= "00011";
wait for cCLK_PER;

--xor $3, $1, $3
-- xors the values in regs 1 and 3 then stores result in reg 3

		ctl <= "1011";
		 rs_s <= "00001";
		 rt_s <= "00011";
		 rd_s <= "00011";
wait for cCLK_PER;

--or $3, $1, $0
-- ors the values in regs 1 and 0 then stores result in reg 3

		ctl <= "0111";
		 rs_s <= "00001";
		 rt_s <= "00000";
		 rd_s <= "00011";
wait for cCLK_PER;

--or $3, $1, $3
-- ors the values in regs 1 and 3 then stores result in reg 3

		ctl <= "0111";
		 rs_s <= "00001";
		 rt_s <= "00011";
		 rd_s <= "00011";
wait for cCLK_PER;

--and $3, $1, $0
-- ands the values in regs 1 and 0 then stores result in reg 3

		ctl <= "1111";
		 rs_s <= "00001";
		 rt_s <= "00000";
		 rd_s <= "00011";
wait for cCLK_PER;

--and $3, $1, $3
-- ands the values in regs 1 and 3 then stores result in reg 3

		ctl <= "1111";
		 rs_s <= "00001";
		 rt_s <= "00011";
		 rd_s <= "00011";
wait for cCLK_PER;

--Begin ALU Tests
--addi, $25, $25, $0, 349525
-- addi 349525 to register $0 and store in $25

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"5555";
		 rd_s <= "11001";
wait for cCLK_PER;


--sll, $25, $25, $25, 16
-- sll 16 to register $25 and store in $25

		ctl <= "1110";
		 rs_s <= "11001";
		 in_immedate_value <=X"0010";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $1, $1, $0, 349525
-- addi 349525 to register $0 and store in $1

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"5555";
		 rd_s <= "00001";
wait for cCLK_PER;


--add, $25, $1, $25
--add  $1 and $25 and store in $25

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "11001";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $26, $26, $0, 3355443
-- addi 3355443 to register $0 and store in $26

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"3333";
		 rd_s <= "11010";
wait for cCLK_PER;


--sll, $26, $26, $26, 16
-- sll 16 to register $26 and store in $26

		ctl <= "1110";
		 rs_s <= "11010";
		 in_immedate_value <=X"0010";
		 rd_s <= "11010";
wait for cCLK_PER;


--addi, $1, $1, $0, 3355443
-- addi 3355443 to register $0 and store in $1

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"3333";
		 rd_s <= "00001";
wait for cCLK_PER;


--add, $26, $1, $25
--add  $1 and $25 and store in $26

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "11001";
		 rd_s <= "11010";
wait for cCLK_PER;


--nor, $27, $25, $26
--nor  $25 and $26 and store in $27

		ctl <= "1101";
		 rs_s <= "11001";
		 rt_s <= "11010";
		 rd_s <= "11011";
wait for cCLK_PER;


--nand, $27, $25, $26
--nand  $25 and $26 and store in $27

		ctl <= "0011";
		 rs_s <= "11001";
		 rt_s <= "11010";
		 rd_s <= "11011";
wait for cCLK_PER;


--xor, $27, $25, $26
--xor  $25 and $26 and store in $27

		ctl <= "1011";
		 rs_s <= "11001";
		 rt_s <= "11010";
		 rd_s <= "11011";
wait for cCLK_PER;


--or, $27, $25, $26
--or  $25 and $26 and store in $27

		ctl <= "0111";
		 rs_s <= "11001";
		 rt_s <= "11010";
		 rd_s <= "11011";
wait for cCLK_PER;


--and, $27, $25, $26
--and  $25 and $26 and store in $27

		ctl <= "1111";
		 rs_s <= "11001";
		 rt_s <= "11010";
		 rd_s <= "11011";
wait for cCLK_PER;


--addi, $25, $25, $0, 349525
-- addi 349525 to register $0 and store in $25

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"5555";
		 rd_s <= "11001";
wait for cCLK_PER;


--sll, $25, $25, $25, 16
-- sll 16 to register $25 and store in $25

		ctl <= "1110";
		 rs_s <= "11001";
		 in_immedate_value <=X"0010";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $1, $1, $0, 349525
-- addi 349525 to register $0 and store in $1

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"5555";
		 rd_s <= "00001";
wait for cCLK_PER;


--add, $25, $1, $25
--add  $1 and $25 and store in $25

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "11001";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $25, $25, $0, 65535
-- addi 65535 to register $0 and store in $25

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"ffff";
		 rd_s <= "11001";
wait for cCLK_PER;


--sll, $25, $25, $25, 16
-- sll 16 to register $25 and store in $25

		ctl <= "1110";
		 rs_s <= "11001";
		 in_immedate_value <=X"0010";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $1, $1, $0, 65535
-- addi 65535 to register $0 and store in $1

		ctl <= "0100";
		 rs_s <= "00000";
		 in_immedate_value <=X"ffff";
		 rd_s <= "00001";
wait for cCLK_PER;


--add, $25, $1, $25
--add  $1 and $25 and store in $25

		ctl <= "0101";
		 rs_s <= "00001";
		 rt_s <= "11001";
		 rd_s <= "11001";
wait for cCLK_PER;


--add, $27, $25, $25
--add  $25 and $25 and store in $27

		ctl <= "0101";
		 rs_s <= "11001";
		 rt_s <= "11001";
		 rd_s <= "11011";
wait for cCLK_PER;


--sub, $27, $25, $25
--sub  $25 and $25 and store in $27

		ctl <= "1001";
		 rs_s <= "11001";
		 rt_s <= "11001";
		 rd_s <= "11011";
wait for cCLK_PER;


wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;

end process;

end behavior;


