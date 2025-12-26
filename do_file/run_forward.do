
# Clear previous work
if {[file exists work]} {
    vdel -all
}

# Create work library
vlib work



vlog -work work ALU.v
vlog -work work Reg_File.v
vlog -work work Control_Unit.v
vlog -work work CCR.v

vlog -work work Instruction_Memory.v
vlog -work work Data_Memory.v

vlog -work work Pipeline_Registers.v

vlog -work work PC_Unit.v
vlog -work work Stack_Pointer_Unit.v
vlog -work work Branch_Unit.v
vlog -work work Interrupt_Unit.v
vlog -work work Output_Unit.v

vlog -work work Hazard_Detection_Unit.v
vlog -work work Forwarding_Unit.v

vlog -work work Processor_Top.v

vlog -work work forward_test.v


vsim -voptargs=+acc work.forward_test

do wave_forward.do

run 1000ns


wave zoom full