quit -sim
vlib work
rmdir /Q /S work
vlib work

vcom -work work arrayPackage.vhd



#do ALU/compile.do

vcom -work work  ALU/andg2.vhd
vcom -work work  ALU/xorg2.vhd
vcom -work work  ALU/org2.vhd
vcom -work work  ALU/mux.vhd   
vcom -work work  ALU/arrayPackage.vhd
vcom -work work  ALU/mux_nbit_struct.vhd   
vcom -work work  ALU/adder.vhd 
vcom -work work  ALU/add_sub_struct_1bit.vhd
vcom -work work  ALU/ALU1bit.vhd
vcom -work work  ALU/ALU32bit.vhd



#TODO
#do Barrel_Shifter/compile.do
vcom -work work  Barrel_Shifter/mux2.vhd
vcom -work work  Barrel_Shifter/reverse.vhd
vcom -work work  Barrel_Shifter/bsLR.vhd



vcom -work work FullALU.vhd


vsim work.FullALU


add wave -position insertpoint  \
sim:/fullalu/in_ia \
sim:/fullalu/in_ib \
sim:/fullalu/in_ctl \
sim:/fullalu/out_data \
sim:/fullalu/out_overflow \
sim:/fullalu/out_carry \
sim:/fullalu/out_zero

