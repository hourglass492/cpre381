vlib work
vcom -work work andg2.vhd
vcom -work work invg.vhd
vcom -work work xorg2.vhd
vcom -work work adder.vhd
vcom -work work adder_nbit_flow.vhd
vcom -work work adder_nbit_struct.vhd
vcom -work work org2.vhd
vcom -work work adder_testbed.vhd

vsim work.adder_testbed

add wave sim:/adder_testbed/*



run 10000