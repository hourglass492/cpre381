entity control is 
    port(  
        i_instructions          : in std_logic_vector(0 to 5);


        regDst                  : out std_logic;
        branch                  : out std_logic;
        memRead                 : out std_logic;
        memToReg                : out std_logic;
        ALUOp                   : out std_logic_vector(0 to 4);
        memWrite                : out std_logic;
        ALUSrc                  : out std_logic;
        RegWrite                : out std_logic

    );

end control;


-- Notes on ALUop ctl signals
-- if it is a shift op ALUop(0) = 0
-- if it is a alu op ALUop(0) = 1
-- in order of ALUOp(1) to ALUOp(3)
--     sll 111
--     sla 110
--     srl 101
--     sra 100
-- for alu ops
--     and 111
--     or 110
--     xor 101
--     nand 100
--     nor 011
--     add 010
--     sub 001
--     slt 00











