vlib work
vcom -work work andg2.vhd
vcom -work work invg.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd


vcom -work work decoder5to32_flow.vhd


vcom -work work mux_nbit_struct.vhd

vcom -work work mux_nbit_nbitto1_struct.vhd

vcom -work work registerFile_nbit_struct.vhd
vcom -work work register_nbit_struct.vhd

vcom -work work adder.vhd
vcom -work work adder_nbit_struct.vhd


vcom -work work mux.vhd   
vcom -work work mux_nbit_nbitto1_struct.vhd



vcom -work work registerFile_nbit_struct.vhd



vcom -work work micro_processor_arch.vhd

vcom -work work tb_micro_processor_arch.vhd


vsim work.tb_micro_processor_arch

add wave sim:/tb_micro_processor_arch/*

