quit -sim
rmdir /Q /S work
vlib work

vcom -work work arrayPackage.vhd


do BasicGates/compile.do
do adder/compile.do
do ALU/compile.do
do ALUControl/compile.do
do Control/compile.do
do extender/compile.do
do instructionMem/compile.do
do pc/compile.do
do register/compile.do

vcom -work work IntegratedDatapath.vhd
vcom -work work tb_IntegratedDatapath.vhd

