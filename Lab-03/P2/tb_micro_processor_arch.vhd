-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_micro_processor.vhd
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

entity tb_micro_processor is
  generic(gCLK_HPER   : time := 50 ns, log2_Of_num_of_inputs : integer := 2, N : integer := 31);
end tb_micro_processor;

architecture behavior of tb_micro_processor is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component micro_processor
    port(  
        in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
        in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
        in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
    
    
        in_immedate_value  : in std_logic_vector(0 to N);
        in_control         : in std_logic_vector(0 to 1);
    
        i_CLK              : in std_logic;
        i_RST              : in std_logic

    );
  end component;

  -- Temporary signals to connect to the micro_processor component.
  signal s_CLK, s_RST : std_logic;
  signal in_select_rd, in_select_rs, in_select_rt : in std_logic_vector(0 to log2_Of_num_of_inputs);
  signal in_control : in std_logic_vector(0 to 1);
  signal in_immedate_value  : in std_logic_vector(0 to N);
  

begin

  DUT: micro_processor 
  port map(
        
            in_select_rd       => in_select_rd,
            in_select_rs       => in_select_rs,
            in_select_rt       => in_select_rt,


            in_immedate_value  => in_immedate_value,
            in_control         => in_control,

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
    -- Reset 
    i_RST <= '1';
    wait for cCLK_PER;



    --TODO repeate this for every register 1-10
    -- Store values for reg 1-10
    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  








    --add $11, $1, $2
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  



    --sub $12, $11, $3
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  



    --add $13, $12, $4
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  


    --sub $14, $13, $5
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  


    --add $15, $14, $6
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  


    --sub $16, $15, $7
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  

    --add $17, $16, $8
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  



    --sub $18, $17, $9
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  



    --add $19,$18,$10
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  



    --addi $20, $0, 35
    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  



    --add $21,$19,$20
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= '1'; -- destination register
    in_select_rs <= '0'; --source register
    in_select_rt <= '0'; --secound register
    in_immedate_value <= '0'; --immidate value
    wait for cCLK_PER;  










  end process;
  
end behavior;
