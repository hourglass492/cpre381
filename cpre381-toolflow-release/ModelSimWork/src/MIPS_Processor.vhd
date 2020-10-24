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
signal internal_reg_we  : std_logic;

signal ALU_ib                           : std_logic_vector(0 to N-1);
--signal ALU_ib                           : std_logic_vector(0 to N-1);
signal ALU_ctl                          : std_logic_vector(0 to 3);
signal ALU_sum                          : std_logic_vector(0 to N-1);
signal nothingTwo                       : std_logic;    
signal nothing                          : std_logic;
signal zero                             : std_logic;
--signal ALU_sum                         : std_logic_vector(0 to N-1);
signal ALU_sum_bottom_10                : std_logic_vector(0 to 9);           
signal internal_mem_we                  : std_logic;     
signal data_read                        : std_logic_vector(0 to N-1);
signal reg_dst							: std_logic;
signal ALUOpIn							: std_logic_vector(0 to 3);   

signal PCnumber                         : std_logic_vector(0 to 11);   






        --constants start
            signal high                           :std_logic := '1'  ;
            signal low                            :std_logic  := '0';
        --constants end

        -- register inputs and immidates
            signal internal_rs                 : std_logic_vector(0 to N-1);
            signal internal_rt                 : std_logic_vector(0 to N-1);
            signal register_write_data                 : std_logic_vector(0 to N-1);
            signal internal_imm                : std_logic_vector(0 to N-1);
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
            signal branch                              : std_logic;
            signal memRead                             : std_logic;
            signal memToReg                            : std_logic;
            signal ALUOp                               : std_logic_vector(0 to 4);
            signal memWrite                            : std_logic;
            signal ALUSrc                              : std_logic;
            signal regWrite                            : std_logic;
        --ctl signals end 

        -- buses start
            signal ALU2ndInput                         : std_logic_vector(0 to N-1);
            signal programCounter                      : std_logic_vector(0 to N-1);
            signal ALUOutput                           : std_logic_vector(0 to N-1);
            signal memoryOutput                        : std_logic_vector(0 to N-1);
        -- buses end


    
    -- end signal
	
	
    --components
        component registerFile_nbit_struct
            port(
                i_rd                       : in std_logic_vector(0 to N-1);
                in_select_rs               : in std_logic_vector(0 to 4);
                in_select_rt               : in std_logic_vector(0 to 4);
                in_select_rd               : in std_logic_vector(0 to 4);
                i_WE                       : in std_logic;
                i_CLK                      : in std_logic;
                i_RST                      : in std_logic;
            
            
                o_rt                       : out std_logic_vector(0 to N-1);
                o_rs                       : out std_logic_vector(0 to N-1)


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
            generic(N : integer := 31);
            port(
                
                in_ia              : in std_logic_vector(0 to N-1);
                in_ib              : in std_logic_vector(0 to N-1);
                in_ctl             : in std_logic_vector(0 to 3);


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
            i_control    : in std_logic;     -- 0 to extend sign, 1 to extend 0's
            i_D          : in std_logic_vector( 0 to 15);     -- Data input
            o_Q          : out std_logic_vector( 0 to 31)       -- Data  output

            );
        end component;



        component control
            port(  
     
    		opcode				  : in std_logic_vector(0 to 5);

    		ALUControl            : out std_logic_vector(0 to 5);
    		ALUSrc        		  : out std_logic;
    		MemtoReg           	  : out std_logic;
    		s_DMemWr              : out std_logic;
		s_RegWr               : out std_logic;
		s_Lui                 : out std_logic;
		RegDst                : out std_logic

            );
        end component;

        component pc
            port(  
                i_branch                : in std_logic;
                i_zero                  : in std_logic;
                i_immedate              : in std_logic_vector(0 to 25);

                o_instruction_number    : out std_logic_vector(0 to 11)

            );
        end component;

    --end components

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  s_Halt <='1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

  -- TODO: Implement the rest of your processor below this comment! 
  
  
  
  
  
  
  
  
 --architecture IntegratedDatapath_arch of MIPS_Processor is

  




    --begin

   
    -- instruction binary to signals

         rs_select        <= instruction(21 to 25);
        
         rt_select        <= instruction(16 to 20);

        -- if statment to select if instruction bits 20-16 or 15-11
         rd_select        <= instruction(16 to 20) when reg_dst = '0' else
				 instruction(11 to 15);
                                        
        
        

        --instruction bits 15 - 0
         internal_raw_immidates <= instruction(0 to 15);

         func_select <= instruction(0 to 5);


    -- end instruction binary to signals


    extender: extender16bit_flow
        port map(
            i_control    => low,     -- 0 to extend sign, 1 to extend 0's
            i_D          => internal_raw_immidates,     -- Data input
            o_Q          => internal_imm 
    );



    -- mux to output the rt data
    reg: registerFile_nbit_struct
        port map(
            i_rd               => register_write_data, --value to load
            in_select_rs       => rs_select, -- next 3 select the register to pull from for each value
            in_select_rt       => rt_select,
            in_select_rd       => rd_select,
            i_WE               => internal_reg_we,
            i_CLK              => i_CLK,
            i_RST              => i_RST,
        
        
            o_rt               => internal_rt,
            o_rs               => internal_rs
    );


    ALUmux: mux_nbit_struct 
        port map(
                    i_a         => internal_imm,
                    i_b         => internal_rt,
                    i_select    => ALUsrc,
                    o_z         => ALU_ib    
    );

                
    ALU: FullALU
        port map(
            in_ia             => internal_rs,
            in_ib             => ALU_ib,
            in_ctl       	  => ALUOpIn,
			
            out_data          => ALU_sum,
			out_overflow	  => nothingTwo,
            out_carry         => nothing,-- not useing carry right now
			out_zero		  => zero
    );


    result_mux: mux_nbit_struct 
        port map(
                    i_a         => data_read,
                    i_b         => ALU_sum,  
                    i_select    => memToReg,
                    o_z         => register_write_data    
    );


    G1:  for j in 22 to 31 generate
        ALU_sum_bottom_10(j-22) <= ALU_sum(j);
    end generate;


--    dmem: mem
--        port map(
--                clk	        => i_CLK,
--                addr	    => ALU_sum_bottom_10,
--                data	    => internal_rt,
--                we		    => internal_mem_we ,
--                q		    => data_read
--    );



    counter: pc
        port map(  
            i_branch                => branch,
            i_zero                  => zero,
            i_immedate              => instruction(0 to 25),

            o_instruction_number    => PCnumber

    );




--    imem: mem
--        port map(
--                clk	        => i_CLK,
--                addr	    => PCnumber(0 to 9),
--                data	    => instruction,
--                we		    => '0' 
--    );

    ctl: control
    port map(  

     
    	opcode			=> instruction(26 to 31),

	--Not sure why this ishere
    	--ALUControl            => ALUOp,
    	ALUSrc        		=> ALUSrc,
    	MemtoReg           	=> memToReg,
    	s_DMemWr              => internal_mem_we,
	s_RegWr               => RegWrite,
	--s_Lui                 : out std_logic;
	RegDst                => regDst
           
    );


    ALUctl: ALUControler
	port map( 
        opcode          => instruction(26 to 31),
        funct           => instruction(0 to 5),

        ALUControl                 => ALUOpIn --4 bit
    );


-- signal remapping
-- reverse signals
gen32: for i in 0 to 31 generate
	oALUOut(i) <= ALU_sum(31-i);
	s_DMemAddr(i) <= ALU_sum(31-i);--????
	s_DMemData(i) <= internal_rt(31-i);
	s_DMemOut(i) <= data_read(31-i);
	s_RegWrData(i) <= register_write_data(31-i);
	s_NextInstAddr(i) <= PCnumber(31-i); --????
	s_Inst(i) <= instruction(31-i);
end generate;

s_DMemWr <= internal_mem_we;
s_RegWr <= regWrite;

gen4: for i in 0 to 4 generate
	s_RegWrAddr(i) <= in_select_rd(4-i);
end generate;

-- TODO: implement hault v0 <= internal_rt; --????

  
  
  
  
  
  
  

end structure;
