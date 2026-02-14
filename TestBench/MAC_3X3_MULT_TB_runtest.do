setactivelib -work
#Compiling UUT module design files

comp -include "$dsn\src\TestBench\MAC_3X3_MULT_TB.v"
asim +access +r MAC_3X3_MULT_tb

wave
wave -noreg SYS_CLOCK
wave -noreg SCLR
wave -noreg LOAD
wave -noreg A
wave -noreg B
wave -noreg MAC_OUT

run

#End simulation macro
