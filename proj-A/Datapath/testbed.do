quit -sim
rmdir /Q /S work
vlib work

#1
vcom -work work 1/arrayPackage.vhd
vcom -work work 1/andg2.vhd
vcom -work work 1/decoder5to32_flow.vhd
vcom -work work 1/dff.vhd
vcom -work work 1/extender16bit_flow.vhd   
vcom -work work 1/invg.vhd
vcom -work work 1/mem.vhd
vcom -work work 1/mux.vhd
vcom -work work 1/mux2.vhd
vcom -work work 1/org2.vhd
vcom -work work 1/reverse.vhd
vcom -work work 1/xorg2.vhd




#2
vcom -work work 2/adder_nbit_struct.vhd
vcom -work work 2/adder.vhd
vcom -work work 2/bsLR.vhd
vcom -work work 2/mux_nbit_struct.vhd
vcom -work work 2/register_nbit_struct.vhd   
vcom -work work 2/structual_1Complement.vhd


#3
vcom -work work 3/add_sub_struct_1bit.vhd
vcom -work work 3/mux_nbit_nbitto1_struct.vhd

#4
vcom -work work 4/ALU1bit.vhd
vcom -work work 4/registerFile_nbit_struct.vhd

#5
vcom -work work 5/ALU32Bit.vhd

vcom -work work FullALU.vhd
vcom -work work IntegratedDatapath.vhd
vcom -work work tb_IntegratedDatapath.vhd


vsim work.tb_IntegratedDatapath
mem load -infile dmem.hex -format hex /thing_im_testing/dmem/ram


add wave -position insertpoint sim:/tb_integrateddatapath/*
add wave -position insertpoint  \
sim:/tb_integrateddatapath/rd_s \
sim:/tb_integrateddatapath/rs_s \
sim:/tb_integrateddatapath/rt_s \
sim:/tb_integrateddatapath/ctl \
sim:/tb_integrateddatapath/in_immedate_value



#ALU input output waves
add wave -position insertpoint  \
sim:/tb_integrateddatapath/thing_im_testing/ALU/in_ia \
sim:/tb_integrateddatapath/thing_im_testing/ALU/in_ib \
sim:/tb_integrateddatapath/thing_im_testing/ALU/in_ctl \
sim:/tb_integrateddatapath/thing_im_testing/ALU/out_data


