quit -sim

vlib work
vcom -work work andg2.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd
vcom -work work mux.vhd   
vcom -work work arrayPackage.vhd


vcom -work work adder.vhd 
vcom -work work add_sub_struct_1bit.vhd

vcom -work work ALU1bit.vhd

vcom -work work ALU32bit.vhd

vsim work.ALU32Bit


add wave sim:/ALU32Bit/*

force -freeze sim:/alu1bit/in_ctl 0 0
force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0


