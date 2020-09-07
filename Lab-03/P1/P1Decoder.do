vlib work
vcom -work work andg2.vhd
vcom -work work invg.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd


vcom -work work decoder5to32_flow.vhd


vcom -work work mux_nbit_struct.vhd

vcom -work work mux_nbit_nbitto1_struct.vhd

vcom -work work registerFile_nbit_struct.vhd


vcom -work work adder.vhd
vcom -work work adder_nbit_struct.vhd


vcom -work work mux.vhd   
vcom -work work mux_nbit_nbitto1_struct.vhd




vsim work.decoder5to32_flow

add wave sim:/decoder5to32_flow/*




force -freeze sim:/decoder5to32_flow/i_data 0 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 2 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 3 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 4 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 5 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 6 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 7 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 8 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 9 0
run 100
force -freeze sim:/decoder5to32_flow/i_data a 0
run 100
force -freeze sim:/decoder5to32_flow/i_data b 0
run 100
force -freeze sim:/decoder5to32_flow/i_data c 0
run 100
force -freeze sim:/decoder5to32_flow/i_data d 0
run 100
force -freeze sim:/decoder5to32_flow/i_data e 0
run 100
force -freeze sim:/decoder5to32_flow/i_data f 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 11 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 12 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 13 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 14 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 15 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 16 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 17 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 18 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 19 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1a 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1b 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1c 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1d 0
run 100
force -freeze sim:/decoder5to32_flow/i_data 1e 0
run 100