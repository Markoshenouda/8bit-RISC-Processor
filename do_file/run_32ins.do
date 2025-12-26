# Delete old work library
vdel -all

# Create work library
vlib work
vmap work work

# Compile design files
vlog -work work ALU.v
vlog -work work CCR.v
vlog -work work Control_Unit.v
vlog -work work Reg_File.v
vlog -work work Data_Memory.v
vlog -work work Instruction_Memory.v
vlog -work work Pipeline_Registers.v
vlog -work work Forwarding_Unit.v
vlog -work work Hazard_Detection_Unit.v
vlog -work work Branch_Unit.v
vlog -work work Stack_Pointer_Unit.v
vlog -work work PC_Unit.v
vlog -work work Output_Unit.v
vlog -work work Interrupt_Unit.v
vlog -work work Processor_Top.v
vlog -work work Comprehensive_TB.v

# Start simulation
vsim -voptargs=+acc work.Comprehensive_TB

# Load waves
do wave_32ins.do

# Run simulation
run -all

# Zoom full
wave zoom full