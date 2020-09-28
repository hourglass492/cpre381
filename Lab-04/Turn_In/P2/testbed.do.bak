vlib work


vcom -work work mem.vhd  
vcom -work work dff.vhd  
vcom -work work register_nbit_struct.vhd  
vcom -work work tb_mem.vhd  

vsim work.tb_mem


mem load -infile dmem.hex -format hex /tb_mem/dmem/ram

add wave sim:/tb_mem/*




run 4500