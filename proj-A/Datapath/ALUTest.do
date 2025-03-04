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


vsim work.FullALU

add wave -position insertpoint  \
sim:/fullalu/ALU1bit_31/ctl_and \
sim:/fullalu/ALU1bit_31/ctl_or \
sim:/fullalu/ALU1bit_31/ctl_xor \
sim:/fullalu/ALU1bit_31/ctl_nand \
sim:/fullalu/ALU1bit_31/ctl_nor \
sim:/fullalu/ALU1bit_31/ctl_add \
sim:/fullalu/ALU1bit_31/ctl_sub \
sim:/fullalu/ALU1bit_31/ctl_slt




add wave -position insertpoint  \
sim:/fullalu/ALU1bit_31/in_ia \
sim:/fullalu/ALU1bit_31/in_ib \
sim:/fullalu/ALU1bit_31/in_carry \
sim:/fullalu/ALU1bit_31/in_ctl \
sim:/fullalu/ALU1bit_31/out_data \
sim:/fullalu/ALU1bit_31/out_overflow \
sim:/fullalu/ALU1bit_31/out_carry \
sim:/fullalu/ALU1bit_31/out_zero



force -freeze sim:/fullalu/in_ia 32'h33333333 0
force -freeze sim:/fullalu/in_ib 32'h55555555 0
force -freeze sim:/fullalu/in_ctl 4'hB 0

run 400

force -freeze sim:/fullalu/in_ia 32'h33333333 0
force -freeze sim:/fullalu/in_ib 32'h55555555 0
force -freeze sim:/fullalu/in_ctl 4'hC 0

run 400

force -freeze sim:/fullalu/in_ia 32'h33333333 0
force -freeze sim:/fullalu/in_ib 32'h55555555 0
force -freeze sim:/fullalu/in_ctl 4'hD 0

run 400

force -freeze sim:/fullalu/in_ia 32'h33333333 0
force -freeze sim:/fullalu/in_ib 32'h55555555 0
force -freeze sim:/fullalu/in_ctl 4'hE 0

run 400


force -freeze sim:/fullalu/in_ia 32'h33333333 0
force -freeze sim:/fullalu/in_ib 32'h55555555 0
force -freeze sim:/fullalu/in_ctl 4'hF 0

run 400