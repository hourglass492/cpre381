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


#add wave sim:/ALU1bit/*



force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0



#Breif tests for logical operators
force -freeze sim:/alu1bit/in_ia 1 0
force -freeze sim:/alu1bit/in_ib 1 0
force -freeze sim:/alu1bit/in_carry 0 0
force -freeze sim:/alu1bit/in_ctl 3'h7 0
run 100
force -freeze sim:/alu1bit/in_ia 0 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h6 0
run 100
force -freeze sim:/alu1bit/in_ib 0 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h5 0
run 100
force -freeze sim:/alu1bit/in_ia 1 0
run 100
force -freeze sim:/alu1bit/in_ib 1 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h4 0
run 100
force -freeze sim:/alu1bit/in_ia 0 0
run 100
force -freeze sim:/alu1bit/in_ctl 3'h3 0
run 100
force -freeze sim:/alu1bit/in_ib 0 0
run 100




add wave -position insertpoint  \
sim:/alu1bit/out_data \
sim:/alu1bit/out_overflow \
sim:/alu1bit/out_carry \
sim:/alu1bit/out_zero
add wave -position insertpoint  \
sim:/alu1bit/addSub/inter_carry_1 \
sim:/alu1bit/addSub/inter_carry_2
add wave -position insertpoint  \
sim:/alu1bit/addSub/inter_carry_2

# add test
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