-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dff.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_dff is
  generic(gCLK_HPER   : time := 50 ns);
end tb_dff;

architecture behavior of tb_dff is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component m
    port(
          in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
          in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
          in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
      
      
          in_immedate_value  : in std_logic_vector(0 to N);
          in_control         : in std_logic_vector(0 to 1);
      
          i_CLK              : in std_logic;
          i_RST              : in std_logic
    )



  end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WE  : std_logic;
  signal s_D, s_Q : std_logic;

begin

  DUT: dff 
  port map(
           i_CLK => s_CLK, 
           i_RST => s_RST,
           i_WE  => s_WE,
           i_D   => s_D,
           o_Q   => s_Q
           );

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
    -- Reset 
    i_RST <= '1';
    s_WE  <= '0';
    wait for cCLK_PER;



    --- use the add command to load initial values into reg 1-10
    s_RST <= '0';
    s_WE  <= '1';
    s_D   <= '1';
    wait for cCLK_PER;  

    -- Keep '1'
    s_RST <= '0';
    s_WE  <= '0';
    s_D   <= '0';
    wait for cCLK_PER;  

    -- Store '0'    
    s_RST <= '0';
    s_WE  <= '1';
    s_D   <= '0';
    wait for cCLK_PER;  

    -- Keep '0'
    s_RST <= '0';
    s_WE  <= '0';
    s_D   <= '1';
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;
