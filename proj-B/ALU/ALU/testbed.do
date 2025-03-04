quit -sim

vlib work
vcom -work work andg2.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd
vcom -work work mux.vhd   
vcom -work work arrayPackage.vhd


vcom -work work mux_nbit_struct.vhd   

vcom -work work adder.vhd 
vcom -work work add_sub_struct_1bit.vhd

vcom -work work ALU1bit.vhd

vcom -work work ALU32bit.vhd

vsim work.ALU32Bit


#add wave sim:/ALU32Bit/*

add wave -position insertpoint  \
sim:/alu32bit/in_ia \
sim:/alu32bit/in_ib \
sim:/alu32bit/in_ctl
add wave -position insertpoint  \
sim:/alu32bit/out_data
add wave -position insertpoint  \
sim:/alu32bit/out_overflow \
sim:/alu32bit/out_carry \
sim:/alu32bit/out_zero
add wave -position insertpoint  \
sim:/alu32bit/out_overflow


force -freeze sim:/alu32bit/in_ia 32'h55555555 0
force -freeze sim:/alu32bit/in_ib 32'h33333333 0
force -freeze sim:/alu32bit/in_ctl 3'h7 0
run 200

force -freeze sim:/alu32bit/in_ctl 3'h6 0

run 200

force -freeze sim:/alu32bit/in_ctl 3'h5 0

run 200

force -freeze sim:/alu32bit/in_ctl 3'h4 0

run 200

force -freeze sim:/alu32bit/in_ctl 3'h3 0

run 200

#test the arithmitic

force -freeze sim:/alu32bit/in_ctl 3'h2 0

force -freeze sim:/alu32bit/in_ia 32'h80000000 0
force -freeze sim:/alu32bit/in_ib 32'h7fffffff 0


run 200


force -freeze sim:/alu32bit/in_ia 32'h7fffffff 0
force -freeze sim:/alu32bit/in_ib 32'h7ffffffa 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h80000000 0
force -freeze sim:/alu32bit/in_ib 32'h80000001 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h7 0
force -freeze sim:/alu32bit/in_ib 32'h3 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h3 0
force -freeze sim:/alu32bit/in_ib 32'h7 0


run 200




force -freeze sim:/alu32bit/in_ctl 3'h1 0

force -freeze sim:/alu32bit/in_ia 32'h80000000 0
force -freeze sim:/alu32bit/in_ib 32'h7fffffff 0


run 200


force -freeze sim:/alu32bit/in_ia 32'h7fffffff 0
force -freeze sim:/alu32bit/in_ib 32'h7ffffffa 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h80000000 0
force -freeze sim:/alu32bit/in_ib 32'h80000001 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h7 0
force -freeze sim:/alu32bit/in_ib 32'h3 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h3 0
force -freeze sim:/alu32bit/in_ib 32'h7 0


run 200


force -freeze sim:/alu32bit/in_ia 32'h7 0
force -freeze sim:/alu32bit/in_ib 32'h7 0


run 200


force -freeze sim:/alu32bit/in_ctl 3'h0 0

force -freeze sim:/alu32bit/in_ia 32'h80000000 0
force -freeze sim:/alu32bit/in_ib 32'h7fffffff 0


run 200


force -freeze sim:/alu32bit/in_ia 32'h7fffffff 0
force -freeze sim:/alu32bit/in_ib 32'h7ffffffa 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h80000000 0
force -freeze sim:/alu32bit/in_ib 32'h80000001 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h7 0
force -freeze sim:/alu32bit/in_ib 32'h3 0

run 200


force -freeze sim:/alu32bit/in_ia 32'h3 0
force -freeze sim:/alu32bit/in_ib 32'h7 0


run 200


