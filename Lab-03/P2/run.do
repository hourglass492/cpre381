vlib work
vcom -work work andg2.vhd
vcom -work work invg.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd


vcom -work work structual_1Complement.vhd

vcom -work work adder.vhd
vcom -work work adder_nbit_struct.vhd


vcom -work work mux.vhd   
vcom -work work mux_nbit_struct.vhd


vcom -work work add_sub_struct.vhd



vsim work.add_sub_struct

add wave sim:/add_sub_struct/*
force -freeze sim:/add_sub_struct/i_a 50 0
force -freeze sim:/add_sub_struct/i_b 25 0
force -freeze sim:/add_sub_struct/i_select 0 0


run 10000