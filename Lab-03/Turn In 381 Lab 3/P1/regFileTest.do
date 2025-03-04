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

vsim work.registerFile_nbit_struct

add wave sim:/registerFile_nbit_struct/*





force -freeze sim:/registerfile_nbit_struct/i_WE 1 0
force -freeze sim:/registerfile_nbit_struct/i_CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/registerfile_nbit_struct/i_RST 1 0
run 100
force -freeze sim:/registerfile_nbit_struct/i_RST 0 0

force -freeze sim:/registerfile_nbit_struct/i_rd   0
force -freeze sim:/registerfile_nbit_struct/in_select_rd  0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  2 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 2 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  3 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 3 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  4 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 4 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  5 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 5 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  6 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 6 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  7 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 7 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  8 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 8 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  9 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 9 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  a 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd a 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  b 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd b 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  c 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd c 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  d 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd d 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  e 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd e 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  f 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd f 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  10 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 10 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  11 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 11 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  12 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 12 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  13 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 13 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  14 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 14 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  15 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 15 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  16 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 16 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  17 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 17 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  18 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 18 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  19 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 19 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1a 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1a 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1b 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1b 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1c 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1c 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1d 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1d 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1e 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1e 0
run 200


force -freeze sim:/registerfile_nbit_struct/i_rd  1f 0
force -freeze sim:/registerfile_nbit_struct/in_select_rd 1f 0
run 200




force -freeze sim:/registerfile_nbit_struct/in_select_rt   0
force -freeze sim:/registerfile_nbit_struct/in_select_rs  0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  2 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 2 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  3 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 3 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  4 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 4 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  5 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 5 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  6 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 6 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  7 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 7 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  8 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 8 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  9 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 9 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  a 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs a 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  b 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs b 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  c 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs c 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  d 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs d 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  e 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs e 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  f 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs f 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  11 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 11 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  12 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 12 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  13 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 13 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  14 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 14 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  15 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 15 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  16 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 16 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  17 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 17 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  18 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 18 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  19 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 19 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1a 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1a 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1b 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1b 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1c 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1c 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1d 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1d 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1e 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1e 0
run 200


force -freeze sim:/registerfile_nbit_struct/in_select_rt  1f 0
force -freeze sim:/registerfile_nbit_struct/in_select_rs 1f 0
run 200
