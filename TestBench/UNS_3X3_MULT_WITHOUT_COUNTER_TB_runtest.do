setactivelib -work
#Compiling UUT module design files

comp -include "$dsn\src\TestBench\UNS_3X3_MULT_TB.v"
asim +access +r UNS_3X3_MULT_tb

wave
wave -noreg SYS_CLOCK
wave -noreg FSM_ARESET
wave -noreg GO
wave -noreg A
wave -noreg B
wave -noreg F_REG
wave -noreg R2_LT_B_1

run

#End simulation macro
