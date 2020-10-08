quit -sim

vlib work
vcom -work work andg2.vhd
vcom -work work invg.vhd
vcom -work work xorg2.vhd
vcom -work work org2.vhd
vcom -work work mux.vhd   



vcom -work work adder.vhd 
vcom -work work add_sub_struct_1bit.vhd

vcom -work work ALU1bit.vhd



vsim work.ALU1bit


add wave -position insertpoint  \
sim:/alu1bit/in_ia \
sim:/alu1bit/in_ib \
sim:/alu1bit/in_carry \
sim:/alu1bit/in_ctl \
sim:/alu1bit/out_data


force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0



#Breif  for logical operators

# set to 1 1 and test all logical operations
force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h6 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h5 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h4 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h3 0
run 100


# set to 1 0 and test all logical operations
force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h6 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h5 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h4 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h3 0
run 100


# set to 0 1 and test all logical operations
force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h6 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h5 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h4 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h3 0
run 100


# set to 0 0 and test all logical operations
force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h6 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h5 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h4 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h3 0
run 100





# add test

force -freeze sim:/alu1bit/in_ctl 3'h2 0
force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100


# sub test

force -freeze sim:/alu1bit/in_ctl 3'h1 0
force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100


# slt test
force -freeze sim:/alu1bit/in_ctl 3'h0 0
force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 0 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 0 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
run 100

force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 1 0
run 100