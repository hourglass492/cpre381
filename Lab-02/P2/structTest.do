

vcom -work work mux_nbit_struct.vhd

vsim work.mux_nbit_struct

add wave sim:/mux_nbit_struct/*

force -freeze sim:/mux_nbit_struct/i_a 240 0
force -freeze sim:/mux_nbit_struct/i_b 204 0



force -freeze sim:/mux_nbit_struct/i_select 0 0





run 1000


