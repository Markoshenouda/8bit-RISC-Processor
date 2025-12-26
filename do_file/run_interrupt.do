# Compile all Verilog files
vlog ALU.v
vlog Branch_Unit.v
vlog CCR.v
vlog Control_Unit.v
vlog Data_Memory.v
vlog Forwarding_Unit.v
vlog Hazard_Detection_Unit.v
vlog Instruction_Memory.v
vlog Interrupt_Unit.v
vlog Output_Unit.v
vlog PC_Unit.v
vlog Pipeline_Registers.v
vlog Reg_File.v
vlog Stack_Pointer_Unit.v
vlog Processor_Top.v
vlog tb_interrupt.v

# Start simulation
vsim -voptargs=+acc work.tb_interrupt

# Load wave configuration
do wave_interrupt.do

# Run simulation
run 500ns

# Zoom to fit
wave zoom full