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




vsim work.mux_nbit_nbitto1_struct

add wave sim:/mux_nbit_nbitto1_struct/*
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(0) 0 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(2) 2 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(4) 4 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(6) 6 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(1) 1 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(3) 3 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(5) 5 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(7) 7 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 3 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 5 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 7 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 2 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 6 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 4 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 0 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(8) 8 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(9) 9 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(10) 10 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(11) 11 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(12) 12 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(13) 13 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(14) 14 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(15) 15 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(16) 16 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(17) 17 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(18) 18 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(19) 19 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(20) 20 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(21) 21 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(22) 22 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(23) 23 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(24) 24 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(25) 25 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(26) 26 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(27) 27 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(28) 28 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(29) 29 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(30) 30 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(31) 31 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(32) 32 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_data_0(33) 33 0
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 0 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 2 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 3 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 4 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 5 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 6 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 7 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 8 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 9 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select a 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select b 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select c 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select d 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select e 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select f 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 10 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 11 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 12 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 13 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 14 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 15 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 16 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 17 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 18 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 19 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1a 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1b 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1c 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1d 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1e 0
run 100
force -freeze sim:/mux_nbit_nbitto1_struct/in_select 1f 0
run 100
