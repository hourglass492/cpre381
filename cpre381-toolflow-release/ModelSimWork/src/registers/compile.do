
do mux/compile.do
do BasicGates/compile.do

vcom -work work decoder5to32_flow.vhd
vcom -work work register_nbit_struct.vhd
vcom -work work registerFile_nbit_struct.vhd

