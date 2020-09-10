
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mem is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
end tb_mem;

architecture tb_microprocessor2 of tb_mem is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  -- Temporary signals to connect to the mem component.
    signal clk	    : in std_logic;
    signal addr	    : in std_logic_vector((ADDR_WIDTH-1) downto 0);
    signal data	    : in std_logic_vector((DATA_WIDTH-1) downto 0);
    signal we		: in std_logic := '1';
    signal q		: out std_logic_vector((DATA_WIDTH -1) downto 0)

  component mem
    port(  
        signal clk	    : in std_logic;
        signal addr	    : in std_logic_vector((ADDR_WIDTH-1) downto 0);
        signal data	    : in std_logic_vector((DATA_WIDTH-1) downto 0);
        signal we		: in std_logic := '1';
        signal q		: out std_logic_vector((DATA_WIDTH -1) downto 0)

    );
  end component;

  

begin

  dmem: mem 
  port map(
        
    clk     => clk,
    addr    => addr,
    data    => data,
    we      => we,
    q       => q

           );

  
  
  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
        clk <= '0';
        wait for gCLK_HPER;
        clk <= '1';
        wait for gCLK_HPER;
  end process;
  




  -- Testbench process  
  P_TB: process
  begin



--addi, $25, $25, $0, 0
-- add 0 to register $0 and store in $25

		ctl <= "001";
		 rs_s <= "00000";
		 imm <= X"00000000";
		 rd_s <= "11001";
wait for gCLK_HPER;


--addi, $26, $26, $0, 256
-- add 256 to register $0 and store in $26

		ctl <= "001";
		 rs_s <= "00000";
		 imm <= X"00000100";
		 rd_s <= "11010";
wait for gCLK_HPER;


--lw, $1,	0($25)
-- load 0 plus $25 from memory into $1

		ctl <= "111";
		 rt_d <= "00001";
		 rs_s <= "11001";
		 imm <= X"00000000";
wait for gCLK_HPER;


--lw, $2,	4($25)
-- load 4 plus $25 from memory into $2

		ctl <= "111";
		 rt_d <= "00010";
		 rs_s <= "11001";
		 imm <= X"00000004";
wait for gCLK_HPER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
wait for gCLK_HPER;


--sw, $1,	0($26)
-- store $1 at memory location $26 plus 0

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 imm <= X"00000000";
wait for gCLK_HPER;


--lw, $2,	8($25)
-- load 8 plus $25 from memory into $2

		ctl <= "111";
		 rt_d <= "00010";
		 rs_s <= "11001";
		 imm <= X"00000008";
wait for gCLK_HPER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
wait for gCLK_HPER;


--sw, $1,	4($26)
-- store $1 at memory location $26 plus 4

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 imm <= X"00000004";
wait for gCLK_HPER;


--lw, $2,	12($25)
-- load 12 plus $25 from memory into $2

		ctl <= "111";
		 rt_d <= "00010";
		 rs_s <= "11001";
		 imm <= X"0000000c";
wait for gCLK_HPER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
wait for gCLK_HPER;


--sw, $1,	8($26)
-- store $1 at memory location $26 plus 8

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 imm <= X"00000008";
wait for gCLK_HPER;


--lw, $2,	16($25)
-- load 16 plus $25 from memory into $2

		ctl <= "111";
		 rt_d <= "00010";
		 rs_s <= "11001";
		 imm <= X"00000010";
wait for gCLK_HPER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
wait for gCLK_HPER;


--sw, $1,	12($26)
-- store $1 at memory location $26 plus 12

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 imm <= X"0000000c";
wait for gCLK_HPER;


--lw, $2,	20($25)
-- load 20 plus $25 from memory into $2

		ctl <= "111";
		 rt_d <= "00010";
		 rs_s <= "11001";
		 imm <= X"00000014";
wait for gCLK_HPER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
wait for gCLK_HPER;


--sw, $1,	16($26)
-- store $1 at memory location $26 plus 16

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11010";
		 imm <= X"00000010";
wait for gCLK_HPER;


--lw, $2,	24($25)
-- load 24 plus $25 from memory into $2

		ctl <= "111";
		 rt_d <= "00010";
		 rs_s <= "11001";
		 imm <= X"00000018";
wait for gCLK_HPER;


--addi, $1, $1, $2
-- add $1 and $2 and store in $1

		ctl <= "000";
		 rs_s <= "00001";
		 rt_s <= "00010";
wait for gCLK_HPER;


--addi, $27, $27, $26, 512
-- add 512 to register $26 and store in $27

		ctl <= "001";
		 rs_s <= "11010";
		 imm <= X"00000200";
		 rd_s <= "11011";
wait for gCLK_HPER;


--sw, $1,	-4($27)
-- store $1 at memory location $27 plus -4

		ctl <= "101";
		 rt_s <= "00001";
		 rs_s <= "11011";
		 imm <= X"ffffffc";


  end process;
  
end tb_microprocessor2;

