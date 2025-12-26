###############################################################################
# Processor Project - ModelSim Run Script
# Comprehensive compilation and simulation script
###############################################################################

# Clear previous work
if {[file exists work]} {
    vdel -all
}

# Create work library
vlib work

###############################################################################
# COMPILATION PHASE
###############################################################################

echo "========================================="
echo "Starting Compilation..."
echo "========================================="

# Core Components
echo "Compiling Core Components..."
vlog -work work ALU.v
vlog -work work Reg_File.v
vlog -work work Control_Unit.v
vlog -work work CCR.v

# Memory Modules
echo "Compiling Memory Modules..."
vlog -work work Instruction_Memory.v
vlog -work work Data_Memory.v

# Pipeline Registers
echo "Compiling Pipeline Registers..."
vlog -work work Pipeline_Registers.v

# Special Units
echo "Compiling Special Units..."
vlog -work work PC_Unit.v
vlog -work work Stack_Pointer_Unit.v
vlog -work work Branch_Unit.v
vlog -work work Interrupt_Unit.v
vlog -work work Output_Unit.v

# Hazard & Forwarding Units
echo "Compiling Hazard Detection and Forwarding..."
vlog -work work Hazard_Detection_Unit.v
vlog -work work Forwarding_Unit.v

# Top Module
echo "Compiling Top Module..."
vlog -work work Processor_Top.v

# Testbench
echo "Compiling Testbench..."
vlog -work work Hazard_Detection_Test.v

echo "========================================="
echo "Compilation Complete!"
echo "========================================="

###############################################################################
# SIMULATION PHASE
###############################################################################

echo ""
echo "========================================="
echo "Starting Hazard Detection Test..."
echo "========================================="

# Start simulation
vsim -voptargs=+acc work.Hazard_Detection_Test

# Load wave configuration
do wave_hazard.do

# Run simulation
echo ""
echo "Running simulation for 1500ns..."
run 1500ns



# Zoom to fit
wave zoom full