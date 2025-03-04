
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_micro_processor2 is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
end tb_micro_processor2;

architecture behavior of tb_micro_processor2 is

  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  -- Temporary signals to connect to the micro_processor2 component.
  signal i_CLK, i_RST : std_logic;
  signal rd_s : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal  rs_s : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal rt_s : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal ctl :  std_logic_vector(0 to 2);
  signal in_immedate_value  : std_logic_vector(0 to 15);

  component micro_processor2
    port(  
        in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
        in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
        in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    
    
        in_immedate_value  : in std_logic_vector(0 to 15);
        in_control         : in std_logic_vector(0 to 2);
    
        i_CLK              : in std_logic;
        i_RST              : in std_logic

    );
  end component;

  

begin

  thing_im_testing: micro_processor2 
  port map(
        
            in_select_rd       => rd_s,
            in_select_rs       => rs_s,
            in_select_rt       => rt_s,


            in_immedate_value  => in_immedate_value,
            in_control         => ctl,

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
-- add 0 to register $0 and store in $25

		ctl <= "100";
		 rs_s <= "00000";
		 in_immedate_value <=X"0000";
		 rd_s <= "11001";
wait for cCLK_PER;


--addi, $26, $26, $0, 256
-- add 256 to register $0 and store in $26

		ctl <= "100";
		 rs_s <= "00000";
		 in_immedate_value <=X"0100";
		 rd_s <= "11010";
wait for cCLK_PER;


--lw, $1,	0($25)
-- load 0 plus $25 from memory into $1

		ctl <= "111";
		 rd_s <= "00001";
		 rs_s <= "11001";
		 in_immedate_value <= X"0000";
wait for cCLK_PER;


--lw, $2,	4($25)
-- load 4 plus $25 from memory into $2

		ctl <= "111";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0001";
wait for cCLK_PER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	0($26)
-- store $1 at memory location $26 plus 0

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0000";
wait for cCLK_PER;


--lw, $2,	8($25)
-- load 8 plus $25 from memory into $2

		ctl <= "111";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0002";
wait for cCLK_PER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	4($26)
-- store $1 at memory location $26 plus 4

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0001";
wait for cCLK_PER;


--lw, $2,	12($25)
-- load 12 plus $25 from memory into $2

		ctl <= "111";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0003";
wait for cCLK_PER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	8($26)
-- store $1 at memory location $26 plus 8

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0002";
wait for cCLK_PER;


--lw, $2,	16($25)
-- load 16 plus $25 from memory into $2

		ctl <= "111";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0004";
wait for cCLK_PER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	12($26)
-- store $1 at memory location $26 plus 12

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0003";
wait for cCLK_PER;


--lw, $2,	20($25)
-- load 20 plus $25 from memory into $2

		ctl <= "111";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0005";
wait for cCLK_PER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--sw, $1,	16($26)
-- store $1 at memory location $26 plus 16

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 in_immedate_value <=X"0004";
wait for cCLK_PER;


--lw, $2,	24($25)
-- load 24 plus $25 from memory into $2

		ctl <= "111";
		 rd_s <= "00010";
		 rs_s <= "11001";
		 in_immedate_value <= X"0006";
wait for cCLK_PER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
		 rd_s <= "00001";
wait for cCLK_PER;


--addi, $27, $27, $26, 512
-- add 512 to register $26 and store in $27

		ctl <= "100";
		 rs_s <= "11010";
		 in_immedate_value <=X"0200";
		 rd_s <= "11011";
wait for cCLK_PER;


--sw, $1,	-4($27)
-- store $1 at memory location $27 plus -4

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11011";
		 in_immedate_value <=X"ffff";
wait for cCLK_PER;


wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;




wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;








end process;

end behavior;


