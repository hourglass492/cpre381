

vcom -work work mux.vhd

vsim work.mux

add wave sim:/mux/*

force -freeze sim:/mux/i_a 1 0
force -freeze sim:/mux/i_b 0 0






force -freeze sim:/mux/i_select 0 0


run 1000

