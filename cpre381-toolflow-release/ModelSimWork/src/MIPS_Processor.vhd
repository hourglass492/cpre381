-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment
  --signals
signal func_select  : std_logic_vector(0 to 5);


signal ALU_ib                           : std_logic_vector(0 to N-1);
--signal ALU_ib                           : std_logic_vector(0 to N-1);
signal ALU_ctl                          : std_logic_vector(0 to 3);
signal sum                          : std_logic_vector(0 to N-1);
signal nothingTwo                       : std_logic;    
signal nothing                          : std_logic;
signal zero                             : std_logic;
--signal sum                         : std_logic_vector(0 to N-1);
signal DMem_addr                : std_logic_vector(0 to 9);           
signal internal_mem_we                  : std_logic;     
signal data_read                        : std_logic_vector(0 to N-1);
signal reg_Dst							: std_logic;
signal ALUOpIn							: std_logic_vector(0 to 3);   

signal PCnumber                         : std_logic_vector(0 to N-1);   






        --constants start
            signal high                           :std_logic := '1'  ;
            signal low                            :std_logic  := '0';
        --constants end

        -- register inputs and immidates
            signal internal_rs                 : std_logic_vector(0 to N-1);
            signal internal_rt                 : std_logic_vector(0 to N-1);
            signal register_write_data         : std_logic_vector(0 to N-1);
			signal WB_register_write_back_final					   : std_logic_vector(0 to N-1);
            signal internal_imm                : std_logic_vector(0 to N-1);
            signal EX_jumpLocation                : std_logic_vector(0 to N-1);
        -- register inputs and immidates end

        -- binary blob to signals start
            signal instruction                    : std_logic_vector(0 to N-1);
            signal rs_select                   : std_logic_vector(0 to 4);
            signal rt_select                   : std_logic_vector(0 to 4);
            signal rd_select                   : std_logic_vector(0 to 4);
            signal internal_raw_immidates      : std_logic_vector(0 to 15);
        -- binary blob to signals end

        --ctl signals start
            signal regDst                              : std_logic;
			signal loadUpper                              : std_logic;
			signal IsUnsigned                              : std_logic;
			
            signal branch                              : std_logic;
            signal memRead                             : std_logic;
            signal memToReg                            : std_logic;
            signal ALUOp                               : std_logic_vector(0 to 4);
            signal memWrite                            : std_logic;
            signal ALUSrc                              : std_logic;
            signal regWrite                            : std_logic;
            signal jr                                  : std_logic;
			signal varShift								: std_logic;
			signal shiftValue						   : std_logic_vector(0 to 4);
        --ctl signals end 

        -- buses start
            signal ALU2ndInput                         : std_logic_vector(0 to N-1);
            signal programCounter                      : std_logic_vector(0 to N-1);
            signal ALUOutput                           : std_logic_vector(0 to N-1);
            signal memoryOutput                        : std_logic_vector(0 to N-1);
        -- buses end
		
		--LUI
		signal s_internal_imm_shifted					: std_logic_vector(0 to N-1);
		



		signal 	beq                   :  std_logic;
		signal	bne                   :  std_logic;
		signal	jump                  :  std_logic;
		signal	jal                  :  std_logic;
		signal	zeroExtened                  :  std_logic;




    
    -- end signal
	
	
    --components
	
	--pipeline registers
	
		component IF_ID
			port(
				i_CLK             		  : in std_logic;
				i_stall              	  : in std_logic;
				i_if_flush                : in std_logic;
				i_instruction             : in std_logic_vector(0 to N);   
				i_pc         			  : in std_logic_vector(0 to N);   

				o_pc              		  : out std_logic_vector(0 to N);
				o_instruction	  		  : out std_logic_vector(0 to N)
				);
        end component;
		
		component ID_EX
			port(
                i_CLK             			=> iCLK,
                i_stall              		=> global_stall,
                i_if_flush              	=> global_Flush,
    
    
                i_RS             			: in std_logic_vector(0 to N);   
                i_RT         			 	: in std_logic_vector(0 to N);   
                i_MemtoReg					: in std_logic;
                i_RegWrite					: in std_logic;
                i_MemWrite					: in std_logic;
                i_MemRead					: in std_logic;
                i_ALUSrc					: in std_logic;
                i_RegDst					: in std_logic;
                i_AluOp						: in std_logic_vector(0 to 3);
                i_ExtendedImmediate			: in std_logic_vector(0 to N);
                i_RdAddress					: in std_logic_vector(0 to 4);
                i_RtAddress					: in std_logic_vector(0 to 4);
                i_RsAddress					: in std_logic_vector(0 to 4);
                i_ALUSrc        		        : in std_logic;
                i_MemtoReg           	        : in std_logic;
                i_s_DMemWr                    : in std_logic;
                i_s_RegWr                     : in std_logic;
                i_s_Lui                       : in std_logic;
                i_RegDst                      : in std_logic;
                i_beq                         : in std_logic;
                i_bne                         : in std_logic;
                i_jr                          : in std_logic;
                i_jal                         : in std_logic;
                i_jump                        : in std_logic;
                i_varShift			        : in std_logic;
                i_zeroExtened                 : in std_logic
    
    
    
    
    
    
    
    
    
    
    
    
                o_RT               			: out std_logic_vector(0 to N);
                o_RS		 	  			: out std_logic_vector(0 to N);
                o_MemtoReg					: out std_logic;
                o_RegWrite					: out std_logic;
                o_MemWrite					: out std_logic;
                o_MemRead					: out std_logic;
                o_ALUSrc					: out std_logic;
                o_RegDst					: out std_logic;
                o_AluOp						: out std_logic_vector(0 to 3);
                o_ExtendedImmediate			: out std_logic_vector(0 to N);
                o_RdAddress					: out std_logic_vector(0 to 4);
                o_RtAddress					: out std_logic_vector(0 to 4);
                o_RsAddress					: out std_logic_vector(0 to 4)
    
                o_ALUSrc        		        : out std_logic
                o_MemtoReg           	        : out std_logic
                o_s_DMemWr                    : out std_logic
                o_s_RegWr                     : out std_logic
                o_s_Lui                       : out std_logic
                o_RegDst                      : out std_logic
                o_beq                         : out std_logic
                o_bne                         : out std_logic
                o_jr                          : out std_logic
                o_jal                         : out std_logic
                o_jump                        : out std_logic
                o_varShift			        : out std_logic
                o_zeroExtened                 : out std_logic
    

				);
        end component;
		
		
		component EX_MEM
			port(
				i_CLK             			: in std_logic;
				i_stall              		: in std_logic;
				i_if_flush              	: in std_logic;
	
				i_ALUOut             		: in std_logic_vector(0 to N);   
				i_MuxOut         			: in std_logic_vector(0 to N);   
				i_MemtoReg					: in std_logic;
				i_RegWrite					: in std_logic;
				i_MemWrite					: in std_logic;
				i_MemRead					: in std_logic;
				i_WriteAdress				: in std_logic_vector(0 to 4);

				o_MuxOut               		: out std_logic_vector(0 to N);
				o_ALUOut		 	  		: out std_logic_vector(0 to N);
				o_MemtoReg					: out std_logic;
				o_RegWrite					: out std_logic;
				o_MemWrite					: out std_logic;
				o_MemRead					: out std_logic;
				o_WriteAdress				: out std_logic_vector(0 to 4)
				
				);
		end component;
		
		
		component MEM_WB
			port(
				i_CLK             			: in std_logic;
				i_stall              		: in std_logic;
				i_if_flush              	: in std_logic;
	
				i_ALUOut             		: in std_logic_vector(0 to N);   
				i_MemOut         			: in std_logic_vector(0 to N);   
				i_MemtoReg					: in std_logic;
				i_RegWrite					: in std_logic;
				i_WriteAdress				: in std_logic_vector(0 to 4);

				o_MemOut                	: out std_logic_vector(0 to N);
				o_ALUOut		 	  		: out std_logic_vector(0 to N);
				o_MemtoReg					: out std_logic;
				o_RegWrite					: out std_logic;
				o_WriteAdress				: out std_logic_vector(0 to 4)

				);
		end component;

	
	
	
	--regester file
	
	
        component registerFile_nbit_struct
            port(
                i_rd                       : in std_logic_vector(0 to N-1);
                in_select_rs               : in std_logic_vector(0 to 4);
                in_select_rt               : in std_logic_vector(0 to 4);
                in_select_rd               : in std_logic_vector(0 to 4);
                i_WE                       : in std_logic;
                i_CLK                      : in std_logic;
                i_RST                      : in std_logic;
				jal               			: in std_logic;
            
            
                o_rt                       : out std_logic_vector(0 to N-1);
                o_rs                       : out std_logic_vector(0 to N-1);
				
				o_v0			   			: out std_logic_vector(0 to N-1)


                );
        end component;


        component ALUControler
            port(  

    			opcode				  : in std_logic_vector(0 to 5);
				funct				  : in std_logic_vector(0 to 5);
	
    			ALUControl           			: out std_logic_vector(0 to 3);
				IsUnsigned               		: out std_logic

                );
        end component;




            
        --TODO I don't think I need this
        component adder_nbit_struct
            generic(N : integer := 31);
            port(
                


                i_a             : in std_logic_vector(0 to N-1);
                i_b             : in std_logic_vector(0 to N-1);
                i_carry         : in std_logic;
                o_sum           : out std_logic_vector(0 to N-1);
                o_carry         : out std_logic

                );
            
        end component;


        component FullALU
 
            port(
                
                in_ia              : in std_logic_vector(0 to N-1);
                in_ib              : in std_logic_vector(0 to N-1);
                in_ctl             : in std_logic_vector(0 to 3);
			    shiftAmount		   : in std_logic_vector(0 to 4);


                out_data            : out std_logic_vector(0 to N-1);
                out_overflow        : out std_logic;
                out_carry           : out std_logic;
                out_zero            : out std_logic

                );
            
        end component;



        component mux_nbit_struct
            port(
                i_a             : in std_logic_vector(0 to N-1);
                i_b             : in std_logic_vector(0 to N-1);
                i_select        : in std_logic;
                o_z             : out std_logic_vector(0 to N-1)


                );
        end component;

--        component mem
--            port(  
--                signal clk	    : in std_logic;
--                signal addr	    : in std_logic_vector(9 downto 0);
--                signal data	    : in std_logic_vector(N downto 0);
--                signal we		: in std_logic;
--                signal q		: out std_logic_vector(N downto 0)

--            );
--        end component;

        component extender16bit_flow
            port(  
            zeroExtened   		 : in std_logic;     -- 0 to extend sign, 1 to extend 0's

            i_D          		: in std_logic_vector( 0 to 15);     -- Data input
            o_Q          		: out std_logic_vector( 0 to 31)       -- Data  output

            );
        end component;



        component control
            port(  
				opcode				  : in std_logic_vector(0 to 5);
				funct				  : in std_logic_vector(0 to 5);

				--ALUControl            : out std_logic_vector(0 to 5);
				ALUSrc        		  : out std_logic;
				MemtoReg           	  : out std_logic;
				s_DMemWr              : out std_logic;
				s_RegWr               : out std_logic;
				s_Lui                 : out std_logic;
				RegDst                : out std_logic;
				beq                   : out std_logic;
				bne                   : out std_logic;
				jr                    : out std_logic;
				jal                   : out std_logic;
				jump                  : out std_logic;
				varShift			  : out std_logic;
				zeroExtened                  : out std_logic

            );
        end component;

        component pc
            port(  
				i_zero                  : in std_logic;
				i_rst                   : in std_logic;
				i_immedate              : in std_logic_vector(0 to 31);
				i_CLK                   : in std_logic;
				beq                     : in std_logic;
				bne                     : in std_logic;
				jump                    : in std_logic;
				
				
				o_instruction_number    : out std_logic_vector(0 to 31)




            );
        end component;

    --end components

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the
  --memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory.
  --If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be
  --all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;



  

  
  

  
  
  
  
    --begin the instruction decode section

        --DO NOT CHANGE ANY OF THESE SIGNALS, THEY ARE NEEDED
        -- TO HOOK UP WITH THE TEST BENCH
        IMem: mem
        generic map(ADDR_WIDTH => 10,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                addr => s_IMemAddr(11 downto 2),
                data => iInstExt,
                we   => iInstLd,
                q    => s_Inst);
        

        s_Halt <='1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';








    -- Instruction Fech
        IF_ID: IF_IDreg
        port map(
            i_CLK			=> iCLK,
            --TODO-----------------------------------------------------------
            --wire in the registers
            i_stall              	  => global_stall
            i_if_flush                => global_Flush
            i_instruction             : in std_logic_vector(0 to N);   
            i_pc         			  : in std_logic_vector(0 to N);   

            o_pc              		  : out std_logic_vector(0 to N);
            o_instruction	  		  : out std_logic_vector(0 to N)
            );






            

    
        -- instruction binary to signals

            --rs_select        <= instruction(21 to 25);
            --It isn't allways these bytes when it is a sw it is the first register
            rs_select        <= s_Inst(25 downto 21);
            --rs_select <= s_Inst(20 downto 16) when reg_Dst = '0' else
            --		s_Inst(25 downto 21)

            
            --rt_select        <= instruction(16 to 20);
            rt_select        <= s_Inst(20 downto 16);


            -- if statment to select if instruction bits 20-16 or 15-11
            --rd_select        <= instruction(16 to 20) when reg_Dst = '0' else
            --		 instruction(11 to 15);
            rd_select        <= "11111" when jal = '1' else
                                s_Inst(20 downto 16) when reg_Dst = '0' else
                                s_Inst(15 downto 11);		 
            
                                            
            
            

            --instruction bits 15 - 0
            internal_raw_immidates <= s_Inst(15 downto 0);

            func_select <= s_Inst(5 downto 0);


        -- end instruction binary to signals






        reg: registerFile_nbit_struct
            port map(
                i_CLK              => iCLK,
                i_RST              => iRST,

                i_rd               => WB_register_write_back_final, --value to load
                in_select_rs       => rs_select, -- next 3 select the register to pull from for each value
                in_select_rt       => rt_select,
                in_select_rd       => WB_rd_select,
                i_WE               => WB_RegWrite,

                jal 				=> jal,
            
            
                o_rt               => internal_rt,
                o_rs               => internal_rs,
                
                o_v0			   => v0
        );




        extender: extender16bit_flow
            port map(
                zeroExtened    => zeroExtened,--IsUnsigned,     -- 0 to extend sign, 1 to extend 0's

                i_D          => internal_raw_immidates,     -- Data input
                o_Q          => internal_imm 
        );
        




        ctl: control
        port map(  

        
                        opcode			=> instruction(0 to 5),
                        funct           => instruction(26 to 31),
                        
                        ALUSrc        		=> ALUSrc,
                        MemtoReg           	=> memToReg,
                        s_DMemWr              => internal_mem_we,
                        s_RegWr               => RegWrite,
                        s_Lui                 => loadUpper,
                        RegDst                => reg_Dst,

                        beq                  => beq,
                        jr                   => jr,
                        bne                  => bne,
                        jal					=> jal,
                        jump                  => jump,
                        varShift			=> varShift,
                        zeroExtened                  => zeroExtened


            
        );


        ALUctl: ALUControler
        port map( 
            opcode          => instruction(0 to 5),
            funct           => instruction(26 to 31),

            ALUControl      => ALUOpIn, --4 bit
            IsUnsigned		=> IsUnsigned
        );


    






    -- Start Instruction Exicute components --I think I just need to put in the input signals


        --TODO There are doubles in this that need to be removed
        component ID_EX
        port(
            i_CLK             			=> iCLK,
            i_stall              		=> global_stall,
            i_if_flush              	=> global_Flush,


            i_RS             			: in std_logic_vector(0 to N);   
            i_RT         			 	: in std_logic_vector(0 to N);   
            i_MemtoReg					: in std_logic;
            i_RegWrite					: in std_logic;
            i_MemWrite					: in std_logic;
            i_MemRead					: in std_logic;
            i_ALUSrc					: in std_logic;
            i_RegDst					: in std_logic;
            i_AluOp						: in std_logic_vector(0 to 3);
            i_ExtendedImmediate			: in std_logic_vector(0 to N);
            i_RdAddress					: in std_logic_vector(0 to 4);
            i_RtAddress					: in std_logic_vector(0 to 4);
            i_RsAddress					: in std_logic_vector(0 to 4);

            i_ALUSrc        		      => ID_ALUSrc
            i_MemtoReg           	      => ID_MemtoReg
            i_s_DMemWr                    => ID_s_DMemWr
            i_s_RegWr                     => ID_s_RegWr
            i_s_Lui                       => ID_s_Lui
            i_RegDst                      => ID_RegDst
            i_beq                         => ID_beq
            i_bne                         => ID_bne
            i_jr                          => ID_jr
            i_jal                         => ID_jal
            i_jump                        => ID_jump
            i_varShift			          => ID_varShift
            i_zeroExtened                 => ID_zeroExtened



            o_RT               			=> EX_rt_data;
            o_RS		 	  			=> EX_internal_rs,
            o_MemtoReg					: out std_logic;
            o_RegWrite					: out std_logic;
            o_MemWrite					: out std_logic;
            o_MemRead					=> EX_MemRead,
            o_ALUSrc					: out std_logic;
            o_RegDst					: out std_logic;
            o_AluOp						=> EX_AluOp,
            o_ExtendedImmediate			=> EX_internal_imm;
            o_RdAddress					=> EX_RdAddress,
            o_RtAddress					: out std_logic_vector(0 to 4); --Don't think we need these -Nicholas
            o_RsAddress					: out std_logic_vector(0 to 4)  --Don't think we need these -Nicholas

            o_ALUSrc        		      => EX_ALUSrc
            o_MemtoReg           	      => EX_MemtoReg
            o_s_DMemWr                    => EX_s_DMemWr
            o_s_RegWr                     => EX_s_RegWr
            o_s_Lui                       => EX_s_Lui
            o_RegDst                      => EX_RegDst -- What is this for?? -Nicholas
            o_beq                         => EX_beq
            o_bne                         => EX_bne
            o_jr                          => EX_jr
            o_jal                         => EX_jal
            o_jump                        => EX_jump
            o_varShift			          => EX_varShift
            o_zeroExtened                 => EX_zeroExtened

            );
        end component;







        ALUInputmux: mux_nbit_struct 
            port map(
                        i_a         => EX_internal_imm,
                        i_b         => EX_rt_data,
                        i_select    => EX_ALUSrc,
                        o_z         => EX_ALU_ib    
        );


        --The amount we want to shift for shift instructions
        EX_shiftValue <= EX_internal_imm (5 to 9) when (EX_varShift = '0') else
            EX_internal_rs(27 to 31);  
                        
                        
        ALU: FullALU
        --generic(N : integer := 31);
            port map(
                in_ia             => EX_internal_rs,
                in_ib             => EX_ALU_ib,
                in_ctl		        => EX_AluOp,
                shiftAmount         => EX_shiftValue,
                
                out_data          => EX_sum,
                out_overflow	  => nothingTwo,--No overflow detection used
                out_carry         => nothing,-- not useing carry right now
                out_zero		  => EX_zero
        );


        --LUI implementation and the pc number whe JAL
        EX_ALUsum <=   internal_raw_immidates & x"0000" when (LUI = '1') else
                    std_logic_vector(to_unsigned(to_integer(unsigned(PCnumber )) + 4, N)) when (jal = '1') else
                    EX_sum;
        



        -- need to be an immideate value for bne, beq, j, and jal, but for jr needs to be the register read
        -- So I made the pc immedate input a 32 bit value and just appended 0's to the front of the immedate
        -- given by the instruction and muxed it so if it is a jr we get the rs val which should be the reg	
        -- we are jumping to
        EX_jumpLocation <= EX_internal_rs when jr = '1' 
                    else EX_internal_imm(2 to 31) & "00"  when (bne = '1' or beq ='1') --signextend
                    else "0000" & instruction(6 to 31) & "00" ; --TODO We can't access the instructions for the jump commands
                        
                        
                    

        --This component contains all of the program counter logic
        counter: pc
            port map(  

                i_rst                   => iRST,
                i_CLK                   => iClk,
                i_zero                  => EX_zero,
                i_immedate              => EX_jumpLocation,
                beq                  => EX_beq, --ctl signal
                bne                  => EX_bne, --ctl signal
                jump                  => EX_jump, --ctl signal

                o_instruction_number    => PCnumber

        );







    -- Start Mem compnents -- Done besides for i_MuxOut

        component EX_MEM
            port(
                i_CLK             			=> iCLK,
                i_stall              		=> global_stall,
                i_if_flush              	=> global_Flush,

                i_ALUOut             		=> EX_ALUsum,   
                i_MuxOut         			: in std_logic_vector(0 to N);   
                i_MemtoReg					=> EX_MemtoReg,
                i_RegWrite					=> EX_s_RegWr,
                i_MemWrite					=> EX_s_DMemWr,
                i_MemRead					=> EX_MemRead,
                i_WriteAdress				=> EX_RdAddress,


                o_MuxOut               		: out std_logic_vector(0 to N);
                o_ALUOut		 	  		=> MEM_ALUOut,
                o_MemtoReg					=> MEM_MemtoReg
                o_RegWrite					=> MEM_RegWrite,
                o_MemWrite					=> MEM_MemWrite,
                o_MemRead					=> MEM_MemRead,
                o_WriteAdress				=> MEM_WriteAdress
                
                );
        end component;


        --This is the loop that generates the address for the memory
        G1:  for j in 22 to 31 generate
            MEM_DMem_addr(j-22) <= MEM_ALUOut(j);
        end generate;



        DMem: mem
        generic map(ADDR_WIDTH => 10,
                    DATA_WIDTH => N)
        port map(clk  => iCLK,
                 addr => s_DMemAddr(11 downto 2),
                 data => s_DMemData, --TODO I'm not sure this is mapped correctly
                 we   => s_DMemWr,
                 q    => s_DMemOut);
    
    



        
    --Start WB -- I think this is done

        		
		component MEM_WB
        port(
            i_CLK             			=> iCLK,
            i_stall              		=> global_stall,
            i_if_flush              	=> global_Flush,

            i_ALUOut             		=> MEM_ALUOut, 
            i_MemOut         			=> MEM_MemOut,
            i_MemtoReg					=> MEM_MemtoReg,
            i_RegWrite					=> MEM_RegWrite,
            i_WriteAdress				=> MEM_WriteAdress,

            o_MemOut                	=> WB_MemOut,
            o_ALUOut		 	  		=> WB_ALUOut,
            o_MemtoReg					=> WB_MemtoReg,
            o_RegWrite					=> WB_RegWrite,
            o_WriteAdress				=> WB_rd_select

            );
        end component;



        WB_register_write_back_final <= WB_MemOut when (WB_MemtoReg = '1') else
            WB_ALUOut;

    --End Proccessor



             
-- signal remapping
    gen32: for i in 0 to 31 generate
        oALUOut(i) <= sum(31-i);
        s_DMemAddr(i) <= MEM_ALUOut(31-i);--????
        s_DMemData(i) <= internal_rt(31-i);
        MEM_MemOut(i) <= s_DMemOut(31-i);
        s_RegWrData(i) <= WB_register_write_back_final(31-i);
        
        --TODO
        --THIS IS THE PROBLEM, I think the PC only has 
        s_NextInstAddr(i) <= PCnumber(31-i);
        instruction(31-i) <=  s_Inst(i);
    end generate;

    s_DMemWr <= MEM_MemWrite;
    s_RegWr <= WB_RegWrite ;

    gen4: for i in 0 to 4 generate
        s_RegWrAddr(i) <= WB_rd_select(4-i);
    end generate;

--Done mapping

  
  
  
  
  
  
  

end structure;
