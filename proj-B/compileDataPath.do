quit -sim
rmdir /Q /S work
vlib work

vcom -work work arrayPackage.vhd


#do BasicGates/compile.do

    vcom -work work BasicGates/andg2.vhd
    vcom -work work BasicGates/dff.vhd
    vcom -work work BasicGates/invg.vhd
    vcom -work work BasicGates/nand.vhd
    vcom -work work BasicGates/org2.vhd
    vcom -work work BasicGates/xorg2.vhd

#do mux/compile.do
    vcom -work work mux/mux.vhd
    vcom -work work mux/mux_nbit_struct.vhd
    vcom -work work mux/mux_nbit_nbitto1_struct.vhd

#do adder/compile.do
    vcom -work work adder/adder.vhd
    vcom -work work adder/adder_nbit_struct.vhd

#do ALU/compile.do

    #do ALU/compile.do

        vcom -work work  ALU/ALU/andg2.vhd
        vcom -work work  ALU/ALU/xorg2.vhd
        vcom -work work  ALU/ALU/org2.vhd
        vcom -work work  ALU/ALU/mux.vhd   
        vcom -work work  ALU/ALU/arrayPackage.vhd
        vcom -work work  ALU/ALU/mux_nbit_struct.vhd   
        vcom -work work  ALU/ALU/adder.vhd 
        vcom -work work  ALU/ALU/add_sub_struct_1bit.vhd
        vcom -work work  ALU/ALU/ALU1bit.vhd
        vcom -work work  ALU/ALU/ALU32bit.vhd

    TODO
    #do Barrel_Shifter/compile.do
        vcom -work work  ALU/Barrel_Shifter/mux2.vhd
        vcom -work work  ALU/Barrel_Shifter/reverse.vhd
        vcom -work work  ALU/Barrel_Shifter/bsLR.vhd    


    vcom -work work FullALU.vhd

#TODO
#do ALUControl/compile.do

#TODO
#do Control/compile.do

#do extender/compile.do
    vcom -work work extender/extender16bit_flow.vhd

#do instructionMem/compile.do
    vcom -work work instructionMem/mem.vhd

#TODO
#do pc/compile.do


#do register/compile.do
    vcom -work work register/decoder5to32_flow.vhd
    vcom -work work register/register_nbit_struct.vhd
    vcom -work work register/registerFile_nbit_struct.vhd


vcom -work work IntegratedDatapath.vhd
vcom -work work tb_IntegratedDatapath.vhd

