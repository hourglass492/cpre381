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
use work.arrayPackage.all;

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
    --Signals
            -- Required data memory signals
            signal s_DMemWr       : std_logic; -- use this signal as the final active high data memory write enable signal
            signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory address input
            signal s_DMemData     : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory data input
            signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- use this signal as the data memory output
            
            -- Required register file signals 
            signal s_RegWr        : std_logic; -- use this signal as the final active high write enable input to the register file
            signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- use this signal as the final destination register address input
            signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- use this signal as the final data memory data input

            -- Required IF_instruction memory signals
            signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
            signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- use this signal as your intended final IF_instruction memory address input.
            signal s_Inst         : std_logic_vector(N-1 downto 0); -- use this signal as the IF_instruction signal 

            -- Required halt signal -- for simulation
            signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
            signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall IF_instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.

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





				

				signal IF_instruction                   : std_logic_vector(0 to 31);


            
        -- All signals used in ID
                -- 1
                signal ID_ALUSrc                        : std_logic;
                signal ID_memToReg                      : std_logic;
                signal ID_internal_mem_we               : std_logic;
                signal ID_RegWrite                      : std_logic;
                signal ID_loadUpper                     : std_logic;
                signal ID_reg_Dst                       : std_logic;
                signal ID_beq                           : std_logic;
                signal ID_jr                            : std_logic;
                signal ID_bne                           : std_logic;
                signal ID_jal                           : std_logic;
                signal ID_jump                          : std_logic;
                signal ID_varShift                      : std_logic;
                signal ID_zeroExtened                   : std_logic;
                signal ID_IsUnsigned                    : std_logic;
                signal ID_syscal                        : std_logic;

                -- 4
                signal ID_ALUOpIn                       : std_logic_vector(0 to 3);

                -- 5
                signal ID_rs_select                     : std_logic_vector(0 to 4);
                signal ID_rt_select                     : std_logic_vector(0 to 4);
                signal ID_rd_select                     : std_logic_vector(0 to 4);

                -- 6
                signal ID_func_select                   : std_logic_vector(0 to 5);


                -- 16                          
                signal ID_internal_raw_immidates        : std_logic_vector(0 to 15);

                -- 32
                signal ID_internal_rt                   : std_logic_vector(0 to 31);
                signal ID_internal_rs                   : std_logic_vector(0 to 31);
                signal ID_internal_imm                  : std_logic_vector(0 to 31);
                signal ID_s_Inst                        : std_logic_vector(31 downto 0);
                signal ID_instruction                   : std_logic_vector(0 to 31);
                signal ID_v0                            : std_logic_vector(0 to 31);
        --End Signals used

        -- start of all signals used in EX stage
                -- 1
                signal EX_ALUSrc            : std_logic;
                signal EX_MemtoReg          : std_logic;
                signal EX_s_DMemWr          : std_logic;
                signal EX_s_RegWr           : std_logic;
                signal EX_s_Lui             : std_logic;
                signal EX_RegDst            : std_logic;
                signal EX_beq               : std_logic;
                signal EX_bne               : std_logic;
                signal EX_jr                : std_logic;
                signal EX_jal               : std_logic;
                signal EX_jump              : std_logic;
                signal EX_varShift          : std_logic;
                signal EX_zeroExtened       : std_logic;
                signal EX_zero			        : std_logic;
                signal EX_syscal                : std_logic;

                -- 4
                signal EX_AluOp                    : std_logic_vector(0 to 3);

                -- 5
                signal EX_RdAddress                : std_logic_vector(0 to 4);
                signal EX_shiftValue               : std_logic_vector(0 to 4);

                -- 32
                signal EX_rt_data                  : std_logic_vector(0 to 31);
                signal EX_internal_rs              : std_logic_vector(0 to 31);
                signal EX_internal_imm             : std_logic_vector(0 to 31);
                signal EX_ALU_ib                   : std_logic_vector(0 to 31);
                signal EX_sum                      : std_logic_vector(0 to 31);
                signal EX_ALUsum                   : std_logic_vector(0 to 31);
              
                signal EX_jumpLocation             : std_logic_vector(0 to 31);

        -- End of all signals used in EX stage

        --Begin signlas for MEM 

            -- 1
            signal MEM_MemtoReg             : std_logic;
            signal MEM_RegWrite             : std_logic;
            signal MEM_MemWrite             : std_logic;
            signal MEM_MemRead              : std_logic;
            signal MEM_syscal                : std_logic;

            -- 10
            signal MEM_RD_WriteAdress          : std_logic_vector(0 to 4);
            signal MEM_DMem_addr            : std_logic_vector(0 to 9);

            -- 32
            signal MEM_ALUOut               : std_logic_vector(0 to 31);
            signal MEM_rt                   : std_logic_vector(0 to 31);
            signal MEM_MemOut               : std_logic_vector(0 to 31);

        --end signlas for MEM 

        --start signals for WB
            -- 1
            signal WB_MemtoReg              : std_logic;
            signal WB_RegWrite              : std_logic;
            signal WB_syscal                : std_logic;

            -- 4
            signal WB_rd_select             : std_logic_vector(0 to 4);


            -- 32
            signal WB_MemOut                : std_logic_vector(0 to 31);
            signal WB_ALUOut                : std_logic_vector(0 to 31);
            signal WB_register_write_back_final                : std_logic_vector(0 to 31);
        --end signals for WB

        signal nothingTwo                       : std_logic;    
        signal nothing                          : std_logic;
        signal global_stall                          : std_logic;
        signal global_Flush                          : std_logic;
        signal DMem_addr                : std_logic_vector(0 to 9);           

        signal PCnumber                         : std_logic_vector(0 to N-1);   

        signal high                           :std_logic := '1'  ;

        signal low                            :std_logic  := '0';




        -- old signals

            --     -- TODO: You may add any additional signals or components your implementation 
            --     --       requires below this comment
            --     --signals
            --     signal func_select  : std_logic_vector(0 to 5);


            --     signal ALU_ib                           : std_logic_vector(0 to N-1);
            --     --signal ALU_ib                           : std_logic_vector(0 to N-1);
            --     signal ALU_ctl                          : std_logic_vector(0 to 3);
            --     signal sum                          : std_logic_vector(0 to N-1);
            --     signal nothingTwo                       : std_logic;    
            --     signal nothing                          : std_logic;
            --     signal zero                             : std_logic;
            --     --signal sum                         : std_logic_vector(0 to N-1);
            --     signal DMem_addr                : std_logic_vector(0 to 9);           
            --     signal internal_mem_we                  : std_logic;     
            --     signal data_read                        : std_logic_vector(0 to N-1);
            --     signal reg_Dst							: std_logic;
            --     signal ALUOpIn							: std_logic_vector(0 to 3);   

            --     signal PCnumber                         : std_logic_vector(0 to N-1);   






            -- --constants start
            --     signal high                           :std_logic := '1'  ;
            --     signal low                            :std_logic  := '0';
            -- --constants end

            -- -- register inputs and immidates
            --     signal internal_rs                 : std_logic_vector(0 to N-1);
            --     signal internal_rt                 : std_logic_vector(0 to N-1);
            --     signal register_write_data         : std_logic_vector(0 to N-1);
            --     signal WB_register_write_back_final					   : std_logic_vector(0 to N-1);
            --     signal internal_imm                : std_logic_vector(0 to N-1);
            --     signal EX_jumpLocation                : std_logic_vector(0 to N-1);
            -- -- register inputs and immidates end

            -- -- binary blob to signals start
            --     signal IF_instruction                    : std_logic_vector(0 to N-1);
            --     signal rs_select                   : std_logic_vector(0 to 4);
            --     signal rt_select                   : std_logic_vector(0 to 4);
            --     signal rd_select                   : std_logic_vector(0 to 4);
            --     signal internal_raw_immidates      : std_logic_vector(0 to 15);
            -- -- binary blob to signals end

            -- --ctl signals start
            --     signal regDst                              : std_logic;
            --     signal loadUpper                              : std_logic;
            --     signal IsUnsigned                              : std_logic;
                
            --     signal branch                              : std_logic;
            --     signal memRead                             : std_logic;
            --     signal memToReg                            : std_logic;
            --     signal ALUOp                               : std_logic_vector(0 to 4);
            --     signal memWrite                            : std_logic;
            --     signal ALUSrc                              : std_logic;
            --     signal regWrite                            : std_logic;
            --     signal jr                                  : std_logic;
            --     signal varShift								: std_logic;
            --     signal shiftValue						   : std_logic_vector(0 to 4);
            -- --ctl signals end 

            -- -- buses start
            --     signal ALU2ndInput                         : std_logic_vector(0 to N-1);
            --     signal programCounter                      : std_logic_vector(0 to N-1);
            --     signal ALUOutput                           : std_logic_vector(0 to N-1);
            --     signal memoryOutput                        : std_logic_vector(0 to N-1);
            -- -- buses end
            
            -- --LUI
            -- signal s_internal_imm_shifted					: std_logic_vector(0 to N-1);
            



            -- signal 	beq                   :  std_logic;
            -- signal	bne                   :  std_logic;
            -- signal	jump                  :  std_logic;
            -- signal	jal                  :  std_logic;
            -- signal	zeroExtened                  :  std_logic;


        -- old signals


    -- end signal
	
	
    --components
	
	    --pipeline registers
        
            component IF_ID
                port(
                    i_CLK             		  : in std_logic;
                    i_stall              	  : in std_logic;
                    i_if_flush                : in std_logic;
                    i_instruction             : in std_logic_vector(0 to 31);   
                    --i_pc         			  : in std_logic_vector(0 to 31);   

                    --o_pc              		  : out std_logic_vector(0 to 31);
                    o_instruction	  		  : out std_logic_vector(0 to 31)
                    );
            end component;
            
            component ID_EX
                port(
                    i_CLK             		  : in std_logic;
                    i_stall              	  : in std_logic;
                    i_if_flush                : in std_logic;
        
        
                    i_RS             			: in std_logic_vector(0 to 31);   
                    i_RT         			 	: in std_logic_vector(0 to 31);   
                    i_MemtoReg					: in std_logic;
                    i_syscall                   : in std_logic;
                    --i_MemWrite					: in std_logic;
                    -- i_MemRead					: in std_logic; --I don't think we need this
                    i_ALUSrc					: in std_logic;
                    i_RegDst					: in std_logic;
                    i_AluOp						: in std_logic_vector(0 to 3);
                    i_ExtendedImmediate			: in std_logic_vector(0 to 31);
                    i_RdAddress					: in std_logic_vector(0 to 4); 
                    --i_RtAddress					: in std_logic_vector(0 to 4); --I don't think these 2 are needed unless we are doing hardward contrloed pipleinings
                    --i_RsAddress					: in std_logic_vector(0 to 4);
                  
                    i_s_DMemWr                    : in std_logic;
                    i_s_RegWr                     : in std_logic;
                    i_s_Lui                       : in std_logic;
                    
                    i_beq                         : in std_logic;
                    i_bne                         : in std_logic;
                    i_jr                          : in std_logic;
                    i_jal                         : in std_logic;
                    i_jump                        : in std_logic;
                    i_varShift			        : in std_logic;
                    i_zeroExtened                 : in std_logic;
        
        
        
        
        
        
        
        
        
        
        
        
                    o_RT               			: out std_logic_vector(0 to 31);
                    o_RS		 	  			: out std_logic_vector(0 to 31);
                    o_MemtoReg					: out std_logic;
                    o_syscall                   : out std_logic;
                    o_RegWrite					: out std_logic;
                    o_MemWrite					: out std_logic;
                    --o_MemRead					: out std_logic;
                    o_ALUSrc					: out std_logic;
                    o_RegDst					: out std_logic;
                    o_AluOp						: out std_logic_vector(0 to 3);
                    o_ExtendedImmediate			: out std_logic_vector(0 to 31);
                    o_RdAddress					: out std_logic_vector(0 to 4);
                    o_RtAddress					: out std_logic_vector(0 to 4);
                    o_RsAddress					: out std_logic_vector(0 to 4);
        
                    
                    
                    o_s_DMemWr                    : out std_logic;
                    o_s_RegWr                     : out std_logic;
                    o_s_Lui                       : out std_logic;
                    
                    o_beq                         : out std_logic;
                    o_bne                         : out std_logic;
                    o_jr                          : out std_logic;
                    o_jal                         : out std_logic;
                    o_jump                        : out std_logic;
                    o_varShift			        : out std_logic;
                    o_zeroExtened                 : out std_logic
        

                    );
            end component;
            
            
            component EX_MEM
                port(
                    i_CLK             			: in std_logic;
                    i_stall              		: in std_logic;
                    i_if_flush              	: in std_logic;
        
                    i_ALUOut             		: in std_logic_vector(0 to 31);   
                    i_MuxOut         			: in std_logic_vector(0 to 31);   
                    i_MemtoReg					: in std_logic;
                    i_syscall                   : in std_logic;
                    i_RegWrite					: in std_logic;
                    i_MemWrite					: in std_logic;
                    -- i_MemRead					: in std_logic; -- I don't think we need this
                    i_WriteAdress				: in std_logic_vector(0 to 4);

                    o_MuxOut               		: out std_logic_vector(0 to 31);
                    o_ALUOut		 	  		: out std_logic_vector(0 to 31);
                    o_MemtoReg					: out std_logic;
                    o_syscall                   : out std_logic;
                    o_RegWrite					: out std_logic;
                    o_MemWrite					: out std_logic;
                    -- o_MemRead					: out std_logic;
                    o_WriteAdress				: out std_logic_vector(0 to 4)--This is the RD address
                    
                    );
            end component;
            
            
            component MEM_WB
                port(
                    i_CLK             			: in std_logic;
                    i_stall              		: in std_logic;
                    i_if_flush              	: in std_logic;
        
                    i_ALUOut             		: in std_logic_vector(0 to 31);   
                    i_MemOut         			: in std_logic_vector(0 to 31);   
                    i_MemtoReg					: in std_logic;
                    i_syscall                   : in std_logic;
                    i_RegWrite					: in std_logic;
                    i_WriteAdress				: in std_logic_vector(0 to 4);

                    o_MemOut                	: out std_logic_vector(0 to 31);
                    o_ALUOut		 	  		: out std_logic_vector(0 to 31);
                    o_syscall                   : out std_logic;
                    o_MemtoReg					: out std_logic;
                    o_RegWrite					: out std_logic;
                    o_WriteAdress				: out std_logic_vector(0 to 4)

                    );
            end component;


        -- end pipeline registers
	
	

        component extender16bit_flow
            port(  
            zeroExtened   		 : in std_logic;     -- 0 to extend sign, 1 to extend 0's

            i_D          		: in std_logic_vector( 0 to 15);     -- Data input
            o_Q          		: out std_logic_vector( 0 to 31)       -- Data  output

            );
        end component;


		component registerFile_nbit_struct
			-- If you cange n you must remake the decoder function
		  generic(N : integer := 31);
		  port(
			 


			i_rd               : in std_logic_vector(0 to 31);
			in_select_rs       : in std_logic_vector(0 to log2_Of_num_of_inputs);
			in_select_rt       : in std_logic_vector(0 to log2_Of_num_of_inputs);
			in_select_rd       : in std_logic_vector(0 to log2_Of_num_of_inputs);
			i_WE               : in std_logic;
			i_CLK              : in std_logic;
			i_RST              : in std_logic;
			jal                : in std_logic;


			o_rt               : out std_logic_vector(0 to 31);
			o_rs               : out std_logic_vector(0 to 31);
			
			o_v0			   : out std_logic_vector(0 to 31)
			
			

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







		component ALUControler
		  port(
		  
			opcode				  : in std_logic_vector(0 to 5);
			funct				  : in std_logic_vector(0 to 5);
			
			
			ALUControl           : out std_logic_vector(0 to 3);
			IsUnsigned               : out std_logic
			);
			
		end component;




       component FullALU
 
            port(
                
                in_ia              : in std_logic_vector(0 to N-1);
                in_ib              : in std_logic_vector(0 to N-1);
                in_ctl             : in std_logic_vector(0 to 3);
		shiftAmount	   : in std_logic_vector(0 to 4);


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



	global_stall <= '0';
    global_Flush   <= iRST;

  -- TODO: This is required to be your final input to your IF_instruction memory. This provides a feasible method to externally load the
  --memory module which means that the synthesis tool must assume it knows nothing about the values stored in the IF_instruction memory.
  --If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be
  --all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;



  

  
  

  
  
  
  
    --begin the IF_instruction Fetch section

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
        




        s_Halt <='1' when ((WB_syscal = '1') and (v0 = "00000000000000000000000000001010")) else '0';








    -- IF_Instruction Decode

        --All signals used in this section
                -- 1
                -- signal ID_zeroExtened                   : std_logic;
                -- signal ID_ALUSrc                        : std_logic;
                -- signal ID_memToReg                      : std_logic;
                -- signal ID_internal_mem_we               : std_logic;
                -- signal ID_RegWrite                      : std_logic;
                -- signal ID_loadUpper                     : std_logic;
                -- signal ID_reg_Dst                       : std_logic;
                -- signal ID_beq                           : std_logic;
                -- signal ID_jr                            : std_logic;
                -- signal ID_bne                           : std_logic;
                -- signal ID_jal                           : std_logic;
                -- signal ID_jump                          : std_logic;
                -- signal ID_varShift                      : std_logic;
                -- signal ID_zeroExtened                   : std_logic;
                -- signal ID_ALUOpIn                       : std_logic;
                -- signal ID_IsUnsigned                    : std_logic;

                -- 4
                -- signal ID_ALUOpIn                       : std_logic_vector(0 to 3);

                -- 5
                -- signal ID_rs_select                     : std_logic_vector(0 to 4);
                -- signal ID_rt_select                     : std_logic_vector(0 to 4);
                -- signal ID_rd_select                     : std_logic_vector(0 to 4);

                -- 6
                -- signal ID_func_select                   : std_logic_vector(0 to 5);


                -- 16                          
                -- signal ID_internal_raw_immidates        : std_logic_vector(0 to 15);

                -- 32
                -- signal ID_internal_rt                   : std_logic_vector(0 to 31);
                -- signal ID_internal_rs                   : std_logic_vector(0 to 31);
                -- signal ID_internal_imm                  : std_logic_vector(0 to 31);
                -- signal ID_s_Inst                        : std_logic_vector(0 to 31);
                -- signal ID_instruction                   : std_logic_vector(0 to 31);
                -- signal ID_v0                            : std_logic;
        --End Signals used
        



        IF_IDreg: IF_ID
        port map(
            i_CLK			=> iCLK,

            i_stall              	  => global_stall,
            i_if_flush                => global_Flush,
            i_instruction          =>  IF_instruction,
            --i_pc         		=>    --TODO We need to propigate the PC through to the EX stage for the JAL command

            -- o_pc              		  : out std_logic_vector(0 to N); --Pretty sure this isn't needed Nicholas
            o_instruction	  	  => ID_instruction
            );







            


        --This could be a problem because we use the down to configuration

        -- IF_instruction binary to signals

            --rs_select        <= ID_instruction(21 to 25);
            --It isn't allways these bytes when it is a sw it is the first register
            ID_rs_select        <= ID_instruction(6 to 10); --TOXDO not sure if these are the correct bits 6 to 10				
            --rs_select <= s_Inst(20 downto 16) when reg_Dst = '0' else
            --		s_Inst(25 downto 21)

            
            --rt_select        <= ID_instruction(16 to 20);
            ID_rt_select        <= ID_instruction(11 to 15);--TOXDO not sure if these are the correct bits 11 to 15								 I think this is correct now


            -- if statment to select if IF_instruction bits 20-16 or 15-11
            --rd_select        <= IF_instruction(16 to 20) when reg_Dst = '0' else
            --		 IF_instruction(11 to 15);
            ID_rd_select        <= "11111" when ID_jal = '1' else
                                ID_instruction(11 to 15) when ID_reg_Dst = '0' else --TOXDO not sure if these are the correct bits		 I think this is correct now
                                ID_instruction(16 to 20);		 		--TOXDO not sure if these are the correct bits					 I think this is correct now
            
                                            
            
            

            --IF_instruction bits 15 - 0
            ID_internal_raw_immidates <= ID_instruction(16 to 31); --I think this is correct now

            ID_func_select <= ID_instruction(26 to 31); --TOXDO not sure if these are the correct bits I think this is correct now


            ID_syscal <= '1' when (ID_s_Inst(31 downto 26) = "000000") and (ID_s_Inst(5 downto 0) = "001100") else
                '0';
        -- end IF_instruction binary to signals






        reg: registerFile_nbit_struct
            port map(
                i_CLK              => iCLK,
                i_RST              => iRST,

                i_rd               => WB_register_write_back_final, --value to load
                in_select_rs       => ID_rs_select, -- next 3 select the register to pull from for each value
                in_select_rt       => ID_rt_select,
                in_select_rd       => WB_rd_select,
                i_WE               => WB_RegWrite,

                jal 				=> low,--jal, --TODO we should be able to get rid of this because it is handdled in the EX stage
            
            
                o_rt               => ID_internal_rt,
                o_rs               => ID_internal_rs,
                
                o_v0			   => v0 
        );




        extender: extender16bit_flow
            port map(
                zeroExtened    => ID_zeroExtened,--IsUnsigned,     -- 0 to extend sign, 1 to extend 0's
                i_D          => ID_internal_raw_immidates,     -- Data input

                o_Q          => ID_internal_imm 
        );





        ctl: control
        port map(  


                        opcode			=> ID_instruction(0 to 5),
                        funct           => ID_instruction(26 to 31),
                        
                        ALUSrc        		=> ID_ALUSrc,
                        MemtoReg           	=> ID_memToReg,
                        s_DMemWr              => ID_internal_mem_we,
                        s_RegWr               => ID_RegWrite,
                        s_Lui                 => ID_loadUpper,
                        RegDst                => ID_reg_Dst,

                        beq                  => ID_beq,
                        jr                   => ID_jr,
                        bne                  => ID_bne,
                        jal					=> ID_jal,
                        jump                  => ID_jump,
                        varShift			=> ID_varShift,
                        zeroExtened                  => ID_zeroExtened


            
        );


        ALUctl: ALUControler
        port map( 
            opcode          => ID_instruction(0 to 5),
            funct           => ID_instruction(26 to 31),

            ALUControl      => ID_ALUOpIn, --4 bit
            IsUnsigned		=> ID_IsUnsigned
        );





    -- Start IF_Instruction Exicute components --I think I just need to put in the input signals

        -- start of all signals used in EX stage
                -- -- 1
                -- signal EX_ALUSrc            : std_logic;
                -- signal EX_MemtoReg          : std_logic;
                -- signal EX_s_DMemWr          : std_logic;
                -- signal EX_s_RegWr           : std_logic;
                -- signal EX_s_Lui             : std_logic;
                -- signal EX_RegDst            : std_logic;
                -- signal EX_beq               : std_logic;
                -- signal EX_bne               : std_logic;
                -- signal EX_jr                : std_logic;
                -- signal EX_jal               : std_logic;
                -- signal EX_jump              : std_logic;
                -- signal EX_varShift          : std_logic;
                -- signal EX_zeroExtened       : std_logic;

                -- -- 4
                -- EX_AluOp                    : std_logic_vector(0 to 3);

                -- -- 5
                -- EX_RdAddress                : std_logic_vector(0 to 4);
                -- EX_shiftValue               : std_logic_vector(0 to 4);

                -- -- 32
                -- signal EX_rt_data                  : std_logic_vector(0 to 31);
                -- signal EX_internal_rs              : std_logic_vector(0 to 31);
                -- signal EX_internal_imm             : std_logic_vector(0 to 31);
                -- signal EX_ALU_ib                   : std_logic_vector(0 to 31);
                -- signal EX_sum                      : std_logic_vector(0 to 31);
                -- signal EX_ALUsum                   : std_logic_vector(0 to 31);
                -- signal PCnumber                    : std_logic_vector(0 to 31);
                -- signal EX_jumpLocation             : std_logic_vector(0 to 31);

        -- End of all signals used in EX stage




        --TODO There are doubles in this that need to be removed
        ID_EXreg: ID_EX
        port map(
            i_CLK             			=> iCLK,
            i_stall              		=> global_stall,
            i_if_flush              	=> global_Flush,


            i_RS             			=> ID_internal_rs,
            i_RT         			 	=> ID_internal_rt, 

            -- i_MemRead					: in std_logic; -- I think this isn't needed and can just always be 1
            i_RegDst					=> ID_reg_Dst,
            i_AluOp						=> ID_ALUOpIn,
            i_ExtendedImmediate			=> ID_internal_imm,
            i_RdAddress					=> ID_rd_select,
            i_syscall                   => ID_syscal,
            -- i_RtAddress					: in std_logic_vector(0 to 4); --I don't think these are needed -nicholas
            -- i_RsAddress					: in std_logic_vector(0 to 4);--I don't think these are needed -nicholas

            i_ALUSrc        		      => ID_ALUSrc,
            i_MemtoReg           	      => ID_MemtoReg,
            i_s_DMemWr                    => ID_internal_mem_we,
            i_s_RegWr                     => ID_RegWrite,
            i_s_Lui                       => ID_loadUpper,
            --i_RegDst                      => ID_reg_Dst, -- this is a repeat
            i_beq                         => ID_beq,
            i_bne                         => ID_bne,
            i_jr                          => ID_jr,
            i_jal                         => ID_jal,
            i_jump                        => ID_jump,
            i_varShift			          => ID_varShift,
            i_zeroExtened                 => ID_zeroExtened,



            o_RT               			=> EX_rt_data,
            
            o_RS		 	  			=> EX_internal_rs,
            --o_MemRead					=> EX_MemRead, --I think we can just delete this value
            o_AluOp						=> EX_AluOp,
            o_syscall                   => EX_syscal,
            o_ExtendedImmediate			=> EX_internal_imm,
            o_RdAddress					=> EX_RdAddress,
           -- o_RtAddress					: out std_logic_vector(0 to 4); --Don't think we need these -Nicholas
           -- o_RsAddress					: out std_logic_vector(0 to 4)  --Don't think we need these -Nicholas

            o_ALUSrc        		      => EX_ALUSrc,
            o_MemtoReg           	      => EX_MemtoReg,
            o_s_DMemWr                    => EX_s_DMemWr,
            o_s_RegWr                     => EX_s_RegWr,
            o_s_Lui                       => EX_s_Lui,
            o_RegDst                      => EX_RegDst, 
            o_beq                         => EX_beq,
            o_bne                         => EX_bne,
            o_jr                          => EX_jr,
            o_jal                         => EX_jal,
            o_jump                        => EX_jump,
            o_varShift			          => EX_varShift,
            o_zeroExtened                 => EX_zeroExtened

            );
        


        ALUInputmux: mux_nbit_struct 
            port map(
                        i_a         => EX_internal_imm,
                        i_b         => EX_rt_data,
                        i_select    => EX_ALUSrc,
                        o_z         => EX_ALU_ib    
        );


        --The amount we want to shift for shift IF_instructions
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
        EX_ALUsum <=  EX_internal_imm(16 to 31) & x"0000" when (EX_s_Lui = '1') else --TODO not sure if those are the correct bits to grab for the imm, should be the lower 16
                    std_logic_vector(to_unsigned(to_integer(unsigned(PCnumber )) -4 , N)) when (EX_jal = '1') else --TODO this simply takes what it guesses the pc would be rather then actual pc, need to pass the pc through for this to work properly
                    EX_sum;
        



        -- need to be an immideate value for bne, beq, j, and jal, but for jr needs to be the register read
        -- So I made the pc immedate input a 32 bit value and just appended 0's to the front of the immedate
        -- given by the IF_instruction and muxed it so if it is a jr we get the rs val which should be the reg	
        -- we are jumping to
        EX_jumpLocation <= EX_internal_rs when EX_jr = '1' 
                    else EX_internal_imm(2 to 31) & "00"  when (EX_bne = '1' or EX_beq ='1') --signextend
                    else "0000" & IF_instruction(6 to 31) & "00" ; --TODO We can't access the IF_instructions for the jump commands
                        
                        
                    

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

        --Begin signlas for MEM 

            -- -- 1
            -- signal MEM_MemtoReg             : std_logic;
            -- signal MEM_RegWrite             : std_logic;
            -- signal MEM_MemWrite             : std_logic;
            -- signal MEM_MemRead              : std_logic;

            -- -- 10
            -- signal MEM_RD_WriteAdress          : std_logic_vector(0 to 4);
            -- signal MEM_DMem_addr            : std_logic_vector(0 to 9);

            -- -- 32
            -- signal MEM_ALUOut               : std_logic_vector(0 to 31);
            -- signal MEM_MemOut               : std_logic_vector(0 to 31);

        --end signlas for MEM 


                EX_MEMReg: EX_MEM
                port map(
                    i_CLK             			=> iCLK,
                    i_stall              		=> global_stall,
                    i_if_flush              	=> global_Flush,

                    i_ALUOut             		=> EX_ALUsum,   
                    i_MuxOut         			=> EX_rt_data,  
                    i_MemtoReg					=> EX_MemtoReg,
                    i_syscall                   => EX_syscal,
                    i_RegWrite					=> EX_s_RegWr,
                    i_MemWrite					=> EX_s_DMemWr,
                    --i_MemRead					=> EX_MemRead,
                    i_WriteAdress				=> EX_RdAddress,


                    o_MuxOut               		=> MEM_rt,
                    o_ALUOut		 	  		=> MEM_ALUOut,
                    o_MemtoReg					=> MEM_MemtoReg,
                    o_syscall                   => MEM_syscal,
                    o_RegWrite					=> MEM_RegWrite, -- I don't think this is needed as we can calculate it here
                    o_MemWrite					=> MEM_MemWrite,
                    --o_MemRead					=> MEM_MemRead,
                    o_WriteAdress				=> MEM_RD_WriteAdress
                    
                    );
    


            --This is the loop that generates the address for the memory
            G111:  for j in 22 to 31 generate
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

        --start signals for WB
            -- -- 1
            -- signal WB_MemtoReg              : std_logic;
            -- signal WB_RegWrite              : std_logic;

            -- -- 4
            -- signal WB_rd_select             : std_logic_vector(0 to 4);


            -- -- 32
            -- signal WB_MemOut                : std_logic_vector(0 to 31);
            -- signal WB_ALUOut                : std_logic_vector(0 to 31);
        --end signals for WB



        MEM_WBReg: MEM_WB
        port map(
            i_CLK             			=> iCLK,
            i_stall              		=> global_stall,
            i_if_flush              	=> global_Flush,

            i_ALUOut             		=> MEM_ALUOut, 
            i_MemOut         			=> MEM_MemOut,
            i_syscall                   => MEM_syscal,
            i_MemtoReg					=> MEM_MemtoReg,
            i_RegWrite					=> MEM_RegWrite,
            i_WriteAdress				=> MEM_RD_WriteAdress,

            o_MemOut                	=> WB_MemOut,
            o_syscall                   => WB_syscal,
            o_ALUOut		 	  		=> WB_ALUOut,
            o_MemtoReg					=> WB_MemtoReg,
            o_RegWrite					=> WB_RegWrite,
            o_WriteAdress				=> WB_rd_select

            );




        WB_register_write_back_final <= WB_MemOut when (WB_MemtoReg = '1') else
            WB_ALUOut;
    --End Proccessor



             
-- signal remapping
    gen32: for i in 0 to 31 generate
        oALUOut(i) <= EX_sum(31-i);
        s_DMemAddr(i) <= MEM_ALUOut(31-i);--????
        s_DMemData(i) <= MEM_rt(31-i);
        MEM_MemOut(i) <= s_DMemOut(31-i);
        s_RegWrData(i) <= WB_register_write_back_final(31-i);
        

        s_NextInstAddr(i) <= PCnumber(31-i);
        IF_instruction(31-i) <=  s_Inst(i); --iInstExt
        ID_s_Inst(i) <= ID_instruction(31-i);

    end generate;

    s_DMemWr <= MEM_MemWrite;
    s_RegWr <= WB_RegWrite ;

    gen4: for i in 0 to 4 generate
        s_RegWrAddr(i) <= WB_rd_select(4-i);
    end generate;

--Done mapsping

  
  
  
  
  
  
  

end structure;
