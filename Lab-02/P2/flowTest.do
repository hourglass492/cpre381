







vcom -work work mux_nbit_flow.vhd

vsim work.mux_nbit_flow

add wave sim:/mux_nbit_flow/*

force -freeze sim:/mux_nbit_flow/i_a 240 0
force -freeze sim:/mux_nbit_flow/i_b 204 0



force -freeze sim:/mux_nbit_flow/i_select 0 0





run 1000



