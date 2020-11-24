
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_AllReg is
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4);
end tb_AllReg;

architecture behavior of tb_AllReg is

  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

  -- Temporary signals to connect to the micro_processor2 component.
signal	i_CLK_s             			: std_logic;
signal    i_stall_s              		: std_logic;
signal    i_if_flush_s              	: std_logic;
	
signal	i_instruction_s             : std_logic_vector(0 to 31);   
signal    i_pc_s         			  :  std_logic_vector(0 to 31);  
signal    i_RS_s             			:  std_logic_vector(0 to 31);   
signal    i_RT_s         			 	:  std_logic_vector(0 to 31);
signal	i_ALUOut_s             			:  std_logic_vector(0 to 31);   
signal    i_MuxOut_s         			 	:  std_logic_vector(0 to 31);
signal	i_MemOut_s         			 	:  std_logic_vector(0 to 31); 	

signal	i_MemtoReg_s					:  std_logic;
signal	i_RegWrite_s					:  std_logic;
signal	i_MemWrite_s					:  std_logic;
signal	i_MemRead_s					:  std_logic;
signal	i_ALUSrc_s					:  std_logic;
signal	i_RegDst_s					:  std_logic;

signal	i_AluOp_s						:  std_logic_vector(0 to 3);
signal	i_ExtendedImmediate_s			:  std_logic_vector(0 to 31);
signal	i_RdAddress_s					:  std_logic_vector(0 to 4);
signal	i_RtAddress_s					:  std_logic_vector(0 to 4);
signal	i_RsAddress_s					:  std_logic_vector(0 to 4);
signal	i_WriteAdress_s				:  std_logic_vector(0 to 4);
	
signal	IF_ID_instruction_s             :  std_logic_vector(0 to 31);   
signal    IF_ID_pc_s        			  :  std_logic_vector(0 to 31);  
	
signal    ID_EX_RS_s             			:  std_logic_vector(0 to 31);   
signal    ID_EX_RT_s         			 	:  std_logic_vector(0 to 31);
signal	ID_EX_MemtoReg_s					:  std_logic;
signal	ID_EX_RegWrite_s					:  std_logic;
signal	ID_EX_MemWrite_s					:  std_logic;
signal	ID_EX_MemRead_s					:  std_logic;
signal	ID_EX_ALUSrc_s					:  std_logic;
signal	ID_EX_RegDst_s					:  std_logic;
signal	ID_EX_AluOp_s						:  std_logic_vector(0 to 3);
signal	ID_EX_ExtendedImmediate_s			:  std_logic_vector(0 to 31);
signal	ID_EX_RdAddress_s					:  std_logic_vector(0 to 4);
signal	ID_EX_RtAddress_s					:  std_logic_vector(0 to 4);
signal	ID_EX_RsAddress_s					:  std_logic_vector(0 to 4);
	
signal	EX_MEM_ALUOut_s             			:  std_logic_vector(0 to 31);   
signal    EX_MEM_MuxOut_s         			 	:  std_logic_vector(0 to 31);
signal	EX_MEM_MemtoReg_s					:  std_logic;
signal	EX_MEM_RegWrite_s					:  std_logic;
signal	EX_MEM_MemWrite_s					:  std_logic;
signal	EX_MEM_MemRead_s					:  std_logic;
signal	EX_MEM_WriteAdress_s				:  std_logic_vector(0 to 4);
	
signal	MEM_WB_MemOut_s         			 	:  std_logic_vector(0 to 31); 
signal	MEM_WB_ALUOut_s             			:  std_logic_vector(0 to 31); 	
signal	MEM_WB_MemtoReg_s					:  std_logic;
signal	MEM_WB_RegWrite_s				:  std_logic;
signal	MEM_WB_WriteAdress_s				:  std_logic_vector(0 to 4);

  component AllReg
  port(
     
    i_CLK             			: in std_logic;
    i_stall              		: in std_logic;
    i_if_flush              	: in std_logic;
	
	i_instruction             : in std_logic_vector(0 to 31);   
    i_pc         			  : in std_logic_vector(0 to 31);  
	
    i_RS             			: in std_logic_vector(0 to 31);   
    i_RT         			 	: in std_logic_vector(0 to 31);
	
	i_ALUOut             			: in std_logic_vector(0 to 31);   
    i_MuxOut         			 	: in std_logic_vector(0 to 31);
	i_MemOut         			 	: in std_logic_vector(0 to 31);
 	
	i_MemtoReg					: in std_logic;
	i_RegWrite					: in std_logic;
	i_MemWrite					: in std_logic;
	i_MemRead					: in std_logic;
	i_ALUSrc					: in std_logic;
	i_RegDst					: in std_logic;
	i_AluOp						: in std_logic_vector(0 to 3);
	i_ExtendedImmediate			: in std_logic_vector(0 to 31);
	i_RdAddress					: in std_logic_vector(0 to 4);
	i_RtAddress					: in std_logic_vector(0 to 4);
	i_RsAddress					: in std_logic_vector(0 to 4);
	i_WriteAdress				: in std_logic_vector(0 to 4);
	
	IF_ID_instruction             : out std_logic_vector(0 to 31);   
    IF_ID_pc         			  : out std_logic_vector(0 to 31);  
	
    ID_EX_RS             			: out std_logic_vector(0 to 31);   
    ID_EX_RT         			 	: out std_logic_vector(0 to 31);
	ID_EX_MemtoReg					: out std_logic;
	ID_EX_RegWrite					: out std_logic;
	ID_EX_MemWrite					: out std_logic;
	ID_EX_MemRead					: out std_logic;
	ID_EX_ALUSrc					: out std_logic;
	ID_EX_RegDst					: out std_logic;
	ID_EX_AluOp						: out std_logic_vector(0 to 3);
	ID_EX_ExtendedImmediate			: out std_logic_vector(0 to 31);
	ID_EX_RdAddress					: out std_logic_vector(0 to 4);
	ID_EX_RtAddress					: out std_logic_vector(0 to 4);
	ID_EX_RsAddress					: out std_logic_vector(0 to 4);
	
	EX_MEM_ALUOut             			: out std_logic_vector(0 to 31);   
    EX_MEM_MuxOut         			 	: out std_logic_vector(0 to 31);
	EX_MEM_MemtoReg					: out std_logic;
	EX_MEM_RegWrite					: out std_logic;
	EX_MEM_MemWrite					: out std_logic;
	EX_MEM_MemRead					: out std_logic;
	EX_MEM_WriteAdress				: out std_logic_vector(0 to 4);
	
	MEM_WB_MemOut         			 	: out std_logic_vector(0 to 31); 
	MEM_WB_ALUOut             			: out std_logic_vector(0 to 31); 	
	MEM_WB_MemtoReg					: out std_logic;
	MEM_WB_RegWrite					: out std_logic;
	MEM_WB_WriteAdress				: out std_logic_vector(0 to 4)

	);
  end component;

  

begin

  thing_im_testing: AllReg 
  port map(
        
            i_CLK               => i_CLK_s, 
            i_stall       => i_stall_s, 
            i_if_flush       => i_if_flush_s,
			
			i_instruction               => i_instruction_s, 
            i_pc       => i_pc_s, 
            
			
            i_RS       => i_RS_s,
            i_RT               => i_RT_s,
			
			i_ALUOut               => i_ALUOut_s, 
            i_MuxOut       => i_MuxOut_s, 
            i_MemOut       => i_MemOut_s,
			
            i_MemtoReg              => i_MemtoReg_s,
            i_RegWrite              => i_RegWrite_s,
			i_MemWrite               => i_MemWrite_s, 
            i_MemRead       => i_MemRead_s, 
            i_ALUSrc       => i_ALUSrc_s,
            i_RegDst       => i_RegDst_s,
            i_AluOp               => i_AluOp_s,
            i_ExtendedImmediate              => i_ExtendedImmediate_s,
            i_RdAddress              => i_RdAddress_s,             
            i_RtAddress               => i_RtAddress_s,
            i_RsAddress               => i_RsAddress_s,
			i_WriteAdress	=> i_WriteAdress_s,
			
			IF_ID_instruction       => IF_ID_instruction_s,
            IF_ID_pc               => IF_ID_pc_s,
            ID_EX_RS              => ID_EX_RS_s,
            ID_EX_RT              => ID_EX_RT_s,
			ID_EX_MemtoReg               => ID_EX_MemtoReg_s, 
            ID_EX_RegWrite       => ID_EX_RegWrite_s, 
            ID_EX_MemWrite       => ID_EX_MemWrite_s,
            ID_EX_MemRead       => ID_EX_MemRead_s,
            ID_EX_ALUSrc              => ID_EX_ALUSrc_s,
            ID_EX_RegDst              => ID_EX_RegDst_s,             
            ID_EX_AluOp               => ID_EX_AluOp_s,
            ID_EX_ExtendedImmediate               => ID_EX_ExtendedImmediate_s,
			
			ID_EX_RdAddress       => ID_EX_RdAddress_s,
            ID_EX_RtAddress               => ID_EX_RtAddress_s,
            ID_EX_RsAddress              => ID_EX_RsAddress_s,
            EX_MEM_ALUOut              => EX_MEM_ALUOut_s,
			EX_MEM_MuxOut               => EX_MEM_MuxOut_s, 
            EX_MEM_MemtoReg       => EX_MEM_MemtoReg_s, 
            EX_MEM_RegWrite       => EX_MEM_RegWrite_s,
            EX_MEM_MemWrite       => EX_MEM_MemWrite_s,
            EX_MEM_MemRead               => EX_MEM_MemRead_s,
            EX_MEM_WriteAdress              => EX_MEM_WriteAdress_s,
            MEM_WB_MemOut              => MEM_WB_MemOut_s,             
            MEM_WB_ALUOut               => MEM_WB_ALUOut_s,
            MEM_WB_MemtoReg               => MEM_WB_MemtoReg_s,
			
			MEM_WB_RegWrite               => MEM_WB_RegWrite_s,
            MEM_WB_WriteAdress               => MEM_WB_WriteAdress_s
			

           );

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    i_CLK_s <= '0';
    wait for gCLK_HPER;
    i_CLK_s <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin

wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;
wait for gCLK_HPER;

--Fill Registers no flush

		i_stall_s <= '0';
		i_if_flush_s <= '0';
		
		i_instruction_s <=X"AAAAAAAA";
		i_pc_s <=X"AAAAAAAA";
		i_RS_s <=X"AAAAAAAA";
		i_RT_s <=X"AAAAAAAA";
		i_ALUOut_s <=X"AAAAAAAA";
		i_MuxOut_s <=X"AAAAAAAA";
		i_MemOut_s <=X"AAAAAAAA";
		
		i_MemtoReg_s <= '0';
		i_RegWrite_s <= '0';
		i_MemWrite_s <= '0';
		i_MemRead_s <= '0';
		i_ALUSrc_s <= '0';
		i_RegDst_s <= '0';
		
		i_AluOp_s <= "0100";
		
		i_ExtendedImmediate_s <=X"AAAAAAAA";
		
		i_RdAddress_s <= "00101";
		i_RtAddress_s <= "00101";
		i_RsAddress_s <= "00101";
		i_WriteAdress_s <= "00101";
		
		
		 
		 
wait for cCLK_PER;

--Stall

		i_stall_s <= '1';
		i_if_flush_s <= '0';
		
		i_instruction_s <=X"BBBBBBBB";
		i_pc_s <=X"BBBBBBBB";
		i_RS_s <=X"BBBBBBBB";
		i_RT_s <=X"BBBBBBBB";
		i_ALUOut_s <=X"BBBBBBBB";
		i_MuxOut_s <=X"BBBBBBBB";
		i_MemOut_s <=X"BBBBBBBB";
		
		i_MemtoReg_s <= '1';
		i_RegWrite_s <= '1';
		i_MemWrite_s <= '1';
		i_MemRead_s <= '1';
		i_ALUSrc_s <= '1';
		i_RegDst_s <= '1';
		
		i_AluOp_s <= "0011";
		
		i_ExtendedImmediate_s <=X"BBBBBBBB";
		
		i_RdAddress_s <= "00111";
		i_RtAddress_s <= "00111";
		i_RsAddress_s <= "00111";
		i_WriteAdress_s <= "00111";
		

wait for gCLK_HPER;

--Flush
i_if_flush_s <= '1';

wait for gCLK_HPER;
wait for gCLK_HPER;
--Fill Again New

		i_stall_s <= '0';
		i_if_flush_s <= '0';
		
		i_instruction_s <=X"BBBBBBBB";
		i_pc_s <=X"BBBBBBBB";
		i_RS_s <=X"BBBBBBBB";
		i_RT_s <=X"BBBBBBBB";
		i_ALUOut_s <=X"BBBBBBBB";
		i_MuxOut_s <=X"BBBBBBBB";
		i_MemOut_s <=X"BBBBBBBB";
		
		i_MemtoReg_s <= '1';
		i_RegWrite_s <= '1';
		i_MemWrite_s <= '1';
		i_MemRead_s <= '1';
		i_ALUSrc_s <= '1';
		i_RegDst_s <= '1';
		
		i_AluOp_s <= "0011";
		
		i_ExtendedImmediate_s <=X"BBBBBBBB";
		
		i_RdAddress_s <= "00111";
		i_RtAddress_s <= "00111";
		i_RsAddress_s <= "00111";
		i_WriteAdress_s <= "00111";
		
wait for gCLK_HPER;
wait for gCLK_HPER;

end process;

end behavior;


