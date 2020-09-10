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
use ieee.numeric_std.all;

entity tb_micro_processor is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 2; N : integer := 31);
end tb_micro_processor;

architecture behavior of tb_micro_processor is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  -- Temporary signals to connect to the micro_processor component.
  signal i_CLK, i_RST : std_logic;
  signal in_select_rd : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal  in_select_rs : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal in_select_rt : std_logic_vector(0 to log2_Of_num_of_inputs);
  signal in_control :  std_logic_vector(0 to 1);
  signal in_immedate_value  : std_logic_vector(0 to N);

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

    
    in_select_rd   <= X"1"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"1"; --immidate value
    wait for cCLK_PER;  




    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"2"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"2"; --immidate value
    wait for cCLK_PER;  





    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"3"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"3"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"4"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"4"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"5"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"5"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"6"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"6"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"7"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"7"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"8"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"8"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"9"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"9"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= X"A"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"A"; --immidate value
    wait for cCLK_PER;  







    --add $11, $1, $2
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"1"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"0"; --secound register
    in_immedate_value <= X"0"; --immidate value
    wait for cCLK_PER;  



    --sub $12, $11, $3
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= X"C"; -- destination register
    in_select_rs <= X"B"; --source register
    in_select_rt <= X"3"; --secound register
    in_immedate_value <= "0"; --immidate value
    wait for cCLK_PER;  



    --add $13, $12, $4
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"D"; -- destination register
    in_select_rs <= X"C"; --source register
    in_select_rt <= X"4"; --secound register
    in_immedate_value <= "0"; --immidate value
    wait for cCLK_PER;  


    --sub $14, $13, $5
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= X"E"; -- destination register
    in_select_rs <= X"D"; --source register
    in_select_rt <= X"5"; --secound register
    in_immedate_value <= "0"; --immidate value
    wait for cCLK_PER;  


    --add $15, $14, $6
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"F"; -- destination register
    in_select_rs <= X"E"; --source register
    in_select_rt <= X"6"; --secound register
    in_immedate_value <= "0"; --immidate value
    wait for cCLK_PER;  


    --sub $16, $15, $7
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= X"10"; -- destination register
    in_select_rs <= X"F"; --source register
    in_select_rt <= X"7"; --secound register
    in_immedate_value <= X"0"; --immidate value
    wait for cCLK_PER;  

    --add $17, $16, $8
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"11"; -- destination register
    in_select_rs <= X"10"; --source register
    in_select_rt <= X"8"; --secound register
    in_immedate_value <= X"0"; --immidate value
    wait for cCLK_PER;  









    --sub $18, $17, $9
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= X"12"; -- destination register
    in_select_rs <= X"11"; --source register
    in_select_rt <= X"9"; --secound register
    in_immedate_value <= X"0"; --immidate value
    wait for cCLK_PER;  



    --add $19,$18,$10
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"13"; -- destination register
    in_select_rs <= X"12"; --source register
    in_select_rt <= X"A"; --secound register
    in_immedate_value <= "0"; --immidate value
    wait for cCLK_PER;  



    --addi $20, $0, 35
    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"14"; -- destination register
    in_select_rs <= X"0"; --source register
    in_select_rt <= X"23"; --secound register
    in_immedate_value <= X"0"; --immidate value
    wait for cCLK_PER;  



    --add $21,$19,$20
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= X"15"; -- destination register
    in_select_rs <= X"13"; --source register
    in_select_rt <= X"14"; --secound register
    in_immedate_value <= X"0"; --immidate value
    wait for cCLK_PER;  










  end process;
  
end behavior;

