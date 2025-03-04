quit -sim
vlib work
rmdir /Q /S work
vlib work

vcom -work work arrayPackage.vhd


#do BasicGates/compile.do

    vcom -work work BasicGates/andg2.vhd
    vcom -work work BasicGates/dff.vhd
    vcom -work work BasicGates/invg.vhd
    vcom -work work BasicGates/nandg2.vhd
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

    #TODO
    #do Barrel_Shifter/compile.do
        vcom -work work  ALU/Barrel_Shifter/mux2.vhd
        vcom -work work  ALU/Barrel_Shifter/reverse.vhd
        vcom -work work  ALU/Barrel_Shifter/bsLR.vhd    


    vcom -work work ALU/FullALU.vhd

#TODO
#do ALUControl/compile.do

    vcom -work work ALUControl/ALUControler.vhd

#TODO
#do Control/compile.do
	vcom -work work control/control.vhd


#do extender/compile.do
    vcom -work work extender/extender16bit_flow.vhd

#do instructionMem/compile.do
    vcom -work work instructionMem/mem.vhd


#do pc/compile.do
    vcom -work work PC/BasicGates/andg2.vhd
    vcom -work work PC/BasicGates/dff.vhd
    vcom -work work PC/BasicGates/invg.vhd
    vcom -work work PC/BasicGates/org2.vhd
    vcom -work work PC/BasicGates/xorg2.vhd

    vcom -work work PC/adder.vhd
    vcom -work work PC/adder_nbit_struct.vhd


    vcom -work work PC/mux.vhd
    vcom -work work PC/mux_nbit_struct.vhd


    vcom -work work PC/register_nbit_struct.vhd

    vcom -work work PC/pc.vhd  


#do register/compile.do
    vcom -work work registers/decoder5to32_flow.vhd
    vcom -work work registers/register_nbit_struct.vhd
    vcom -work work registers/registerFile_nbit_struct.vhd


vcom -work work IntegratedDatapath.vhd
vcom -work work tb_IntegratedDatapath.vhd

vsim work.IntegratedDatapath


force -freeze sim:/integrateddatapath/i_CLK 1 0, 0 {50 ns} -r 100