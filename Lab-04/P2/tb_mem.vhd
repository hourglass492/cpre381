
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mem is
  generic(
	gCLK_HPER   : time := 50 ns;
	log2_Of_num_of_inputs : integer := 4;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10;
	N : integer := 31);
end tb_mem;

architecture behavior of tb_mem is


  -- Calculate the clock period as twice the half-period
  constant cCLK_HPER  : time := gCLK_HPER * 2;

  -- Temporary signals to connect to the mem component.
    signal clk	        :  std_logic;
    signal rst		:  std_logic := '1';
    signal addr	        :  std_logic_vector((ADDR_WIDTH-1) downto 0);
    signal data	        :  std_logic_vector((DATA_WIDTH-1) downto 0);
    signal w		:  std_logic := '1';
    signal notw		:  std_logic := '1';
    signal q		:  std_logic_vector((DATA_WIDTH -1) downto 0);

  component mem
    port(  
        signal clk	    : in std_logic;
        signal addr	    : in std_logic_vector((ADDR_WIDTH-1) downto 0);
        signal data	    : in std_logic_vector((DATA_WIDTH-1) downto 0);
        signal we		: in std_logic := '1';
        signal q		: out std_logic_vector((DATA_WIDTH -1) downto 0)

    );
  end component;



  component register_nbit_struct
    port(  

    	signal i_CLK             : in std_logic;
    	signal i_RST             : in std_logic;
    	signal i_WE              : in std_logic;
    	signal  i_D              : in std_logic_vector(0 to N);   

    	signal o_Q               : out std_logic_vector(0 to N)

    );
  end component;







  

begin

  dmem: mem 
  port map(
        
    clk     => clk,
    addr    => addr,
    data    => data,
    we      => w,
    q       => q

           );



  notw <= not w;
  tempReg: register_nbit_struct
  port map(

    	 i_CLK  => clk,    
    	 i_RST  => rst,        
    	 i_WE   => notw,   
    	  i_D   =>  q,        

    	 o_Q    => data              

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
	

		rst <= '1';
		wait for cClk_HPER;
		rst <= '0';
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0000000000";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000000";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000001";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000001";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000010";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000010";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000011";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000011";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000100";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000100";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000101";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000101";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000110";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000110";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000000111";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100000111";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000001000";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100001000";
		wait for cClk_HPER;
		w <= '0';
		 addr <= "0000001001";
		wait for cClk_HPER;


		w <= '1';
		 addr <= "0100001001";
		wait for cClk_HPER;




		w <= '0';
		 addr <= "0100000000";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000001";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000010";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000011";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000100";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000101";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000110";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100000111";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100001000";
		wait for cClk_HPER;


		w <= '0';
		 addr <= "0100001001";
		wait for cClk_HPER;

  end process;
  
end behavior;

