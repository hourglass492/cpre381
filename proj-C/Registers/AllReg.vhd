library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;



entity AllReg is
    -- If you cange n you must remake the decoder function
  generic(gCLK_HPER   : time := 50 ns; log2_Of_num_of_inputs : integer := 4);
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
	
end AllReg;

architecture AllReg_arch of AllReg is



    

    --components
        component IF_ID
            port(
    i_CLK             		  : in std_logic;
	i_stall              	  : in std_logic;
    i_if_flush                : in std_logic;
    i_instruction             : in std_logic_vector(0 to 31);   
    i_pc         			  : in std_logic_vector(0 to 31);   

    o_pc              		  : out std_logic_vector(0 to 31);
	o_instruction	  		  : out std_logic_vector(0 to 31)


                );
        end component;


        component ID_EX
  port(
     
    
    i_CLK             			: in std_logic;
    i_stall              		: in std_logic;
    i_if_flush              	: in std_logic;
    i_RS             			: in std_logic_vector(0 to 31);   
    i_RT         			 	: in std_logic_vector(0 to 31);   
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

    o_RT               			: out std_logic_vector(0 to 31);
	o_RS		 	  			: out std_logic_vector(0 to 31);
	o_MemtoReg					: out std_logic;
	o_RegWrite					: out std_logic;
	o_MemWrite					: out std_logic;
	o_MemRead					: out std_logic;
	o_ALUSrc					: out std_logic;
	o_RegDst					: out std_logic;
	o_AluOp						: out std_logic_vector(0 to 3);
	o_ExtendedImmediate			: out std_logic_vector(0 to 31);
	o_RdAddress					: out std_logic_vector(0 to 4);
	o_RtAddress					: out std_logic_vector(0 to 4);
	o_RsAddress					: out std_logic_vector(0 to 4)

	);
        end component;




            
      
        component EX_MEM is
  
  port(
     
    
    i_CLK             			: in std_logic;
    i_stall              		: in std_logic;
    i_if_flush              	: in std_logic;
	
    i_ALUOut             			: in std_logic_vector(0 to 31);   
    i_MuxOut         			 	: in std_logic_vector(0 to 31);   
	i_MemtoReg					: in std_logic;
	i_RegWrite					: in std_logic;
	i_MemWrite					: in std_logic;
	i_MemRead					: in std_logic;
	i_WriteAdress				: in std_logic_vector(0 to 4);

    o_MuxOut               			: out std_logic_vector(0 to 31);
	o_ALUOut		 	  			: out std_logic_vector(0 to 31);
	o_MemtoReg					: out std_logic;
	o_RegWrite					: out std_logic;
	o_MemWrite					: out std_logic;
	o_MemRead					: out std_logic;
	o_WriteAdress					: out std_logic_vector(0 to 4)

	);
            
        end component;


        component MEM_WB is
  
  port(
     
    
    i_CLK             			: in std_logic;
    i_stall              		: in std_logic;
    i_if_flush              	: in std_logic;
	
    i_ALUOut             			: in std_logic_vector(0 to 31);   
    i_MemOut         			 	: in std_logic_vector(0 to 31);   
	i_MemtoReg					: in std_logic;
	i_RegWrite					: in std_logic;
	i_WriteAdress				: in std_logic_vector(0 to 4);

    o_MemOut                			: out std_logic_vector(0 to 31);
	o_ALUOut		 	  			: out std_logic_vector(0 to 31);
	o_MemtoReg					: out std_logic;
	o_RegWrite					: out std_logic;
	o_WriteAdress					: out std_logic_vector(0 to 4)

	);
            
        end component;



        

    --end components




    begin




    extender: IF_ID
        port map(
            i_CLK    => i_CLK,     
            i_stall          => i_stall,     
            i_if_flush          => i_if_flush,
			i_instruction    => i_instruction,     
            i_pc          => i_pc,
			
			o_pc    => IF_ID_pc,     
            o_instruction          => IF_ID_instruction
    );



   
    reg: ID_EX
        port map(
            i_CLK               => i_CLK, 
            i_stall       => i_stall, 
            i_if_flush       => i_if_flush,
            i_RS       => i_RS,
            i_RT               => i_RT,
            i_MemtoReg              => i_MemtoReg,
            i_RegWrite              => i_RegWrite,
			i_MemWrite               => i_MemWrite, 
            i_MemRead       => i_MemRead, 
            i_ALUSrc       => i_ALUSrc,
            i_RegDst       => i_RegDst,
            i_AluOp               => i_AluOp,
            i_ExtendedImmediate              => i_ExtendedImmediate,
            i_RdAddress              => i_RdAddress,             
            i_RtAddress               => i_RtAddress,
            i_RsAddress               => i_RsAddress,
			
			o_RS       => ID_EX_RS,
            o_RT               => ID_EX_RT,
            o_MemtoReg              => ID_EX_MemtoReg,
            o_RegWrite              => ID_EX_RegWrite,
			o_MemWrite               => ID_EX_MemWrite, 
            o_MemRead       => ID_EX_MemRead, 
            o_ALUSrc       => ID_EX_ALUSrc,
            o_RegDst       => ID_EX_RegDst,
            o_AluOp               => ID_EX_AluOp,
            o_ExtendedImmediate              => ID_EX_ExtendedImmediate,
            o_RdAddress              => ID_EX_RdAddress,             
            o_RtAddress               => ID_EX_RtAddress,
            o_RsAddress               => ID_EX_RsAddress
    );


    ALUmux: EX_MEM 
        port map(
            i_CLK               => i_CLK, 
            i_stall       => i_stall, 
            i_if_flush       => i_if_flush,
			
            i_ALUOut       => i_ALUOut,
            i_MuxOut               => i_MuxOut,
            i_MemtoReg              => i_MemtoReg,
            i_RegWrite              => i_RegWrite,
			i_MemWrite               => i_MemWrite, 
            i_MemRead       => i_MemRead, 
            i_WriteAdress       => i_WriteAdress,
            
			
			o_MuxOut       => EX_MEM_MuxOut,
            o_ALUOut               => EX_MEM_ALUOut,
            o_MemtoReg              => EX_MEM_MemtoReg,
            o_RegWrite              => EX_MEM_RegWrite,
			o_MemWrite               => EX_MEM_MemWrite, 
            o_MemRead       => EX_MEM_MemRead, 
            o_WriteAdress       => EX_MEM_WriteAdress
            
    );

                
    ALU: MEM_WB
        port map(
            i_CLK               => i_CLK, 
            i_stall       => i_stall, 
            i_if_flush       => i_if_flush,
			
            i_ALUOut       => i_ALUOut,
            i_MemOut               => i_MemOut,
            i_MemtoReg              => i_MemtoReg,
            i_RegWrite              => i_RegWrite,
            i_WriteAdress       => i_WriteAdress,
            
			
			o_MemOut       => MEM_WB_MemOut,
            o_ALUOut               => MEM_WB_ALUOut,
            o_MemtoReg              => MEM_WB_MemtoReg,
            o_RegWrite              => MEM_WB_RegWrite,
            o_WriteAdress       => MEM_WB_WriteAdress
    );


    




end AllReg_arch;