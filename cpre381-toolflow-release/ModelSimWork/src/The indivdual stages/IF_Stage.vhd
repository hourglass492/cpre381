
signal global_stall                     : std_logic;
signal global_Flush                     : std_logic;
signal iCLK                             : std_logic;
signal iRST                             : std_logic;
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
 



        IF_ID: IF_IDreg
        port map(
            i_CLK			=> iCLK,
            --TODO-----------------------------------------------------------
            --wire in the registers
            i_stall              	  => global_stall
            i_if_flush                => global_Flush
            i_IF_instruction          =>  IF_instruction,
            -- i_pc         			  : in std_logic_vector(0 to N);   

            -- o_pc              		  : out std_logic_vector(0 to N); --Pretty sure this isn't needed Nicholas
            o_IF_instruction	  	  => ID_instruction
            );

        





            


        --This could be a problem because we use the down to configuration
    
        -- IF_instruction binary to signals

            --rs_select        <= IF_instruction(21 to 25);
            --It isn't allways these bytes when it is a sw it is the first register
            ID_rs_select        <= ID_s_Inst(25 downto 21);
            --rs_select <= s_Inst(20 downto 16) when reg_Dst = '0' else
            --		s_Inst(25 downto 21)

            
            --rt_select        <= IF_instruction(16 to 20);
            ID_rt_select        <= ID_s_Inst(20 downto 16);


            -- if statment to select if IF_instruction bits 20-16 or 15-11
            --rd_select        <= IF_instruction(16 to 20) when reg_Dst = '0' else
            --		 IF_instruction(11 to 15);
            ID_rd_select        <= "11111" when jal = '1' else
                                ID_s_Inst(20 downto 16) when reg_Dst = '0' else
                                ID_s_Inst(15 downto 11);		 
            
                                            
            
            

            --IF_instruction bits 15 - 0
            ID_internal_raw_immidates <= ID_s_Inst(15 downto 0);

            ID_func_select <= ID_s_Inst(5 downto 0);


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

                jal 				=> jal, --TODO we should be able to get rid of this because it is handdled in the EX stage
            
            
                o_rt               => ID_internal_rt,
                o_rs               => ID_internal_rs,
                
                o_v0			   => ID_v0 --TODO this needs to be passed through to halt the program at the end
        );




        extender: extender16bit_flow
            port map(
                zeroExtened    => ID_zeroExtened,--IsUnsigned,     -- 0 to extend sign, 1 to extend 0's
                i_D          => ID_internal_raw_immidates,     -- Data input

                o_Q          => ID_internal_imm 
        );
        




        ctl: control
        port map(  

        
                        opcode			=> ID_s_Inst(0 to 5),
                        funct           => ID_s_Inst(26 to 31),
                        
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
            opcode          => ID_s_Inst(0 to 5),
            funct           => ID_s_Inst(26 to 31),

            ALUControl      => ID_ALUOpIn, --4 bit
            IsUnsigned		=> ID_IsUnsigned
        );


    
