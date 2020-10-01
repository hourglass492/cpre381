quit -sim

vlib work
vcom -work work andg2.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd
vcom -work work mux.vhd   
vcom -work work arrayPackage.vhd


vcom -work work mux_nbit_struct.vhd   

vcom -work work adder.vhd 
vcom -work work add_sub_struct_1bit.vhd

vcom -work work ALU1bit.vhd

vcom -work work ALU32bit.vhd

vsim work.ALU32Bit


#add wave sim:/ALU32Bit/*

add wave -position insertpoint  \
sim:/alu32bit/in_ia \
sim:/alu32bit/in_ib \
sim:/alu32bit/in_ctl
add wave -position insertpoint  \
sim:/alu32bit/out_data


force -freeze sim:/alu32bit/in_ctl 3'h2 0
force -freeze sim:/alu32bit/in_ia 0 0
force -freeze sim:/alu32bit/in_ib 0 0


run 1000
force -freeze sim:/alu32bit/in_ib 32'h00000001 0
run 1000
force -freeze sim:/alu32bit/in_ia 32'h00000001 0
run 1000
