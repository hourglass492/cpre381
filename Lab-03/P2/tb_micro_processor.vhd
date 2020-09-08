
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_micro_processor is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4; N : integer := 31);
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

    
    in_select_rd   <= "00001"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000001"; --immidate value
    wait for cCLK_PER;  




    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "00001"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000002"; --immidate value
    wait for cCLK_PER;  





    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "00011"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000003"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "00100"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000004"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "00101"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000005"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "00110"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000006"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "00111"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000007"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "01000"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000008"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "01001"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000009"; --immidate value
    wait for cCLK_PER;  








    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract

    
    in_select_rd   <= "01010"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"0000000A"; --immidate value
    wait for cCLK_PER;  







    --add $11, $1, $2
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "01011"; -- destination register
    in_select_rs <= "00001"; --source register
    in_select_rt <= "00010"; --secound register
    in_immedate_value <= X"00000000"; --immidate value
    wait for cCLK_PER;  



    --sub $12, $11, $3
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= "01100"; -- destination register
    in_select_rs <= "01011"; --source register
    in_select_rt <= "00011"; --secound register
    --in_immedate_value <= "00000000"; --immidate value
    wait for cCLK_PER;  



    --add $13, $12, $4
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "01101"; -- destination register
    in_select_rs <= "01100"; --source register
    in_select_rt <= "00100"; --secound register
    --in_immedate_value <= "00000000"; --immidate value
    wait for cCLK_PER;  


    --sub $14, $13, $5
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= "01110"; -- destination register
    in_select_rs <= "01101"; --source register
    in_select_rt <= "00101"; --secound register
   -- in_immedate_value <= "00000000"; --immidate value
    wait for cCLK_PER;  


    --add $15, $14, $6
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "01111"; -- destination register
    in_select_rs <= "01110"; --source register
    in_select_rt <= "00110"; --secound register
   -- in_immedate_value <= "00000000"; --immidate value
    wait for cCLK_PER;  


    --sub $16, $15, $7
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= "10000"; -- destination register
    in_select_rs <= "01111"; --source register
    in_select_rt <= "00111"; --secound register
    in_immedate_value <= X"00000000"; --immidate value
    wait for cCLK_PER;  

    --add $17, $16, $8
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "10001"; -- destination register
    in_select_rs <= "10000"; --source register
    in_select_rt <= "01000"; --secound register
    in_immedate_value <= X"00000000"; --immidate value
    wait for cCLK_PER;  









    --sub $18, $17, $9
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '1'; -- 1 for subtract


    in_select_rd   <= "10010"; -- destination register
    in_select_rs <= "10001"; --source register
    in_select_rt <= "01001"; --secound register
    in_immedate_value <= X"00000000"; --immidate value
    wait for cCLK_PER;  



    --add $19,$18,$10
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "10011"; -- destination register
    in_select_rs <= "10010"; --source register
    in_select_rt <= "01010"; --secound register
   -- in_immedate_value <= "00000000"; --immidate value
    wait for cCLK_PER;  



    --addi $20, $0, 35
    in_control(0) <= '1'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "10100"; -- destination register
    in_select_rs <= "00000"; --source register
    in_select_rt <= "00000"; --secound register
    in_immedate_value <= X"00000023"; --immidate value
    wait for cCLK_PER;  



    --add $21,$19,$20
    in_control(0) <= '0'; -- 1 for immidate
    in_control(1) <= '0'; -- 1 for subtract


    in_select_rd   <= "10101"; -- destination register
    in_select_rs <= "10011"; --source register
    in_select_rt <= "10100"; --secound register
    in_immedate_value <= X"00000000"; --immidate value
    wait for cCLK_PER;  










  end process;
  
end behavior;

