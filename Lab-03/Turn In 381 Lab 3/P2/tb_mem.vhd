
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mem is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
end tb_mem;

architecture behavior of tb_mem is
  
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

--read all of the 1st 10 addresses
	we <= '0'
		addr <= X"00000000";
		wait for cCLK_PER;

		addr <= X"00000001";
		wait for cCLK_PER;

		addr <= X"00000002";
		wait for cCLK_PER;

		addr <= X"00000003";
		wait for cCLK_PER;

		addr <= X"00000004";
		wait for cCLK_PER;

		addr <= X"00000005";
		wait for cCLK_PER;

		addr <= X"00000006";
		wait for cCLK_PER;

		addr <= X"00000007";
		wait for cCLK_PER;

		addr <= X"00000008";
		wait for cCLK_PER;

		addr <= X"00000009";
		wait for cCLK_PER;




--rewrite all of the address starting at 0x100
	we <= '1'
		addr <= X"00000100";
		data <= X"00000001";
		wait for cCLK_PER;

		addr <= X"00000101";
		data <= X"00000002";
		wait for cCLK_PER;

		addr <= X"00000102";
		data <= X"ffffffd";
		wait for cCLK_PER;

		addr <= X"00000103";
		data <= X"00000004";
		wait for cCLK_PER;

		addr <= X"00000104";
		data <= X"ffffffb";
		wait for cCLK_PER;

		addr <= X"00000105";
		data <= X"00000006";
		wait for cCLK_PER;

		addr <= X"00000106";
		data <= X"ffffff9";
		wait for cCLK_PER;

		addr <= X"00000107";
		data <= X"00000008";
		wait for cCLK_PER;

		addr <= X"00000108";
		data <= X"ffffff7";
		wait for cCLK_PER;

		addr <= X"00000109";
		data <= X"0000000a";
		wait for cCLK_PER;

	we <= '0'



--read all of the address starting at 0x100
		addr <= X"00000100";
		wait for cCLK_PER;

		addr <= X"00000101";
		wait for cCLK_PER;

		addr <= X"00000102";
		wait for cCLK_PER;

		addr <= X"00000103";
		wait for cCLK_PER;

		addr <= X"00000104";
		wait for cCLK_PER;

		addr <= X"00000105";
		wait for cCLK_PER;

		addr <= X"00000106";
		wait for cCLK_PER;

		addr <= X"00000107";
		wait for cCLK_PER;

		addr <= X"00000108";
		wait for cCLK_PER;

		addr <= X"00000109";
		wait for cCLK_PER;

		addr <= X"0000000a";
		wait for cCLK_PER;

		addr <= X"0000000b";
		wait for cCLK_PER;

		addr <= X"0000000c";
		wait for cCLK_PER;

		addr <= X"0000000d";
		wait for cCLK_PER;

		addr <= X"0000000e";
		wait for cCLK_PER;

		addr <= X"0000000f";
		wait for cCLK_PER;

		addr <= X"00000010";
		wait for cCLK_PER;

		addr <= X"00000011";
		wait for cCLK_PER;

		addr <= X"00000012";
		wait for cCLK_PER;

		addr <= X"00000013";
		wait for cCLK_PER;




  end process;
  
end behavior;

