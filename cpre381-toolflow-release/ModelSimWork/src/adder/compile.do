
#do BasicGates/compile.do

vcom -work work BasicGates/andg2.vhd
vcom -work work BasicGates/dff.vhd
vcom -work work BasicGates/invg.vhd
vcom -work work BasicGates/nand.vhd
vcom -work work BasicGates/org2.vhd
vcom -work work BasicGates/xorg2.vhd

vcom -work work adder.vhd
vcom -work work adder_nbit_struct.vhd