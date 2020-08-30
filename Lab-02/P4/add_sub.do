vlib work
vcom -work work andg2.vhd
vcom -work work invg.vhd
vcom -work work xorg2.vhd
vcom -work work adder.vhd
vcom -work work adder_nbit_flow.vhd
vcom -work work adder_nbit_struct.vhd
vcom -work work org2.vhd
vcom -work work adder_testbed.vhd

vsim work.adder_nbit_struct

add wave sim:/adder_nbit_struct/*

force -freeze sim:/adder_nbit_struct/i_a 0 0
force -freeze sim:/adder_nbit_struct/i_b 0 0
force -freeze sim:/adder_nbit_struct/i_carry 1 0


run 10000