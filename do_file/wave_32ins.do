###############################################################################
# ModelSim Waveform Configuration Script
# Organized and Color-Coded Signal Display
###############################################################################

onerror {resume}
quietly WaveActivateNextPane {} 0

# ============================================================================
# SYSTEM SIGNALS
# ============================================================================
add wave -noupdate -divider -height 30 {SYSTEM CONTROL}
add wave -noupdate -color Yellow -label CLK /Comprehensive_TB/clk
add wave -noupdate -color Red -label RST /Comprehensive_TB/rst
add wave -noupdate -color Magenta -label INTERRUPT /Comprehensive_TB/interrupt

# ============================================================================
# TEST CONTROL
# ============================================================================
add wave -noupdate -divider -height 30 {TEST CONTROL}
add wave -noupdate -color Cyan -label "Test Count" -radix unsigned /Comprehensive_TB/test_count
add wave -noupdate -color Green -label "Passed Tests" -radix unsigned /Comprehensive_TB/passed_tests
add wave -noupdate -color Red -label "Failed Tests" -radix unsigned /Comprehensive_TB/failed_tests

# ============================================================================
# FETCH STAGE (IF)
# ============================================================================
add wave -noupdate -divider -height 30 {FETCH STAGE}
add wave -noupdate -color Gold -label "PC Current" -radix hexadecimal /Comprehensive_TB/DUT/pc_current
add wave -noupdate -color Orange -label "Instruction Fetched" -radix hexadecimal /Comprehensive_TB/DUT/instr_fetched
add wave -noupdate -color Pink -label "PC Stall" /Comprehensive_TB/DUT/pc_stall

# ============================================================================
# IF/ID PIPELINE REGISTER
# ============================================================================
add wave -noupdate -divider -height 30 {IF/ID REGISTER}
add wave -noupdate -color Wheat -label "IF/ID Instruction" -radix hexadecimal /Comprehensive_TB/DUT/if_id_instr
add wave -noupdate -color Tan -label "IF/ID PC" -radix hexadecimal /Comprehensive_TB/DUT/if_id_pc
add wave -noupdate -color Violet -label "IF/ID Stall" /Comprehensive_TB/DUT/if_id_stall_hazard

# ============================================================================
# DECODE STAGE (ID)
# ============================================================================
add wave -noupdate -divider -height 30 {DECODE STAGE}
add wave -noupdate -color Aqua -label "Opcode" -radix hexadecimal /Comprehensive_TB/DUT/opcode
add wave -noupdate -color SkyBlue -label "RA" -radix unsigned /Comprehensive_TB/DUT/ra
add wave -noupdate -color SkyBlue -label "RB" -radix unsigned /Comprehensive_TB/DUT/rb
add wave -noupdate -color LightBlue -label "Immediate Value" -radix hexadecimal /Comprehensive_TB/DUT/immediate_value

# ============================================================================
# REGISTER FILE
# ============================================================================
add wave -noupdate -divider -height 30 {REGISTER FILE}
add wave -noupdate -color Gold -label "R0" -radix hexadecimal /Comprehensive_TB/DUT/rf/RF(0)
add wave -noupdate -color Orange -label "R1" -radix hexadecimal /Comprehensive_TB/DUT/rf/RF(1)
add wave -noupdate -color Coral -label "R2" -radix hexadecimal /Comprehensive_TB/DUT/rf/RF(2)
add wave -noupdate -color Red -label "R3 (SP)" -radix hexadecimal /Comprehensive_TB/DUT/rf/RF(3)
add wave -noupdate -color Salmon -label "SP Current" -radix hexadecimal /Comprehensive_TB/DUT/sp_current

# ============================================================================
# CONTROL SIGNALS
# ============================================================================
add wave -noupdate -divider -height 30 {CONTROL SIGNALS}
add wave -noupdate -color Green -label "Reg Write Enable" /Comprehensive_TB/DUT/reg_write_enable
add wave -noupdate -color GreenYellow -label "Mem Read" /Comprehensive_TB/DUT/mem_read
add wave -noupdate -color LimeGreen -label "Mem Write" /Comprehensive_TB/DUT/mem_write
add wave -noupdate -color SpringGreen -label "Is Branch" /Comprehensive_TB/DUT/is_branch
add wave -noupdate -color SeaGreen -label "Is Call" /Comprehensive_TB/DUT/is_call
add wave -noupdate -color DarkGreen -label "Is Ret" /Comprehensive_TB/DUT/is_ret

# ============================================================================
# ID/EX PIPELINE REGISTER
# ============================================================================
add wave -noupdate -divider -height 30 {ID/EX REGISTER}
add wave -noupdate -color Khaki -label "ID/EX Instruction" -radix hexadecimal /Comprehensive_TB/DUT/id_ex_instr
add wave -noupdate -color BurlyWood -label "ID/EX ALU Op" -radix hexadecimal /Comprehensive_TB/DUT/id_ex_alu_op
add wave -noupdate -color Peru -label "ID/EX Reg A" -radix hexadecimal /Comprehensive_TB/DUT/id_ex_reg_a_data
add wave -noupdate -color SandyBrown -label "ID/EX Reg B" -radix hexadecimal /Comprehensive_TB/DUT/id_ex_reg_b_data

# ============================================================================
# FORWARDING
# ============================================================================
add wave -noupdate -divider -height 30 {FORWARDING UNIT}
add wave -noupdate -color Cyan -label "Forward A" -radix unsigned /Comprehensive_TB/DUT/forward_a
add wave -noupdate -color DarkCyan -label "Forward B" -radix unsigned /Comprehensive_TB/DUT/forward_b
add wave -noupdate -color Turquoise -label "Forwarded A" -radix hexadecimal /Comprehensive_TB/DUT/forwarded_a
add wave -noupdate -color PaleTurquoise -label "Forwarded B" -radix hexadecimal /Comprehensive_TB/DUT/forwarded_b

# ============================================================================
# EXECUTE STAGE (EX)
# ============================================================================
add wave -noupdate -divider -height 30 {EXECUTE STAGE}
add wave -noupdate -color Magenta -label "ALU Result" -radix hexadecimal /Comprehensive_TB/DUT/alu_result
add wave -noupdate -color Orchid -label "ALU Zero" /Comprehensive_TB/DUT/alu_z
add wave -noupdate -color Plum -label "ALU Negative" /Comprehensive_TB/DUT/alu_n
add wave -noupdate -color Violet -label "ALU Carry" /Comprehensive_TB/DUT/alu_c
add wave -noupdate -color Purple -label "ALU Overflow" /Comprehensive_TB/DUT/alu_v

# ============================================================================
# FLAGS (CCR)
# ============================================================================
add wave -noupdate -divider -height 30 {CONDITION CODE REGISTER}
add wave -noupdate -color Yellow -label "Current Flags (VCZN)" -radix binary /Comprehensive_TB/DUT/current_flags
add wave -noupdate -color Gold -label "Flag Z" /Comprehensive_TB/DUT/current_flags(0)
add wave -noupdate -color Orange -label "Flag N" /Comprehensive_TB/DUT/current_flags(1)
add wave -noupdate -color OrangeRed -label "Flag C" /Comprehensive_TB/DUT/current_flags(2)
add wave -noupdate -color Red -label "Flag V" /Comprehensive_TB/DUT/current_flags(3)

# ============================================================================
# EX/MEM PIPELINE REGISTER
# ============================================================================
add wave -noupdate -divider -height 30 {EX/MEM REGISTER}
add wave -noupdate -color LightSalmon -label "EX/MEM Instruction" -radix hexadecimal /Comprehensive_TB/DUT/ex_mem_instr
add wave -noupdate -color Salmon -label "EX/MEM ALU Result" -radix hexadecimal /Comprehensive_TB/DUT/ex_mem_alu_result
add wave -noupdate -color DarkSalmon -label "EX/MEM Mem Addr" -radix hexadecimal /Comprehensive_TB/DUT/ex_mem_mem_addr
add wave -noupdate -color Coral -label "EX/MEM Mem Write" /Comprehensive_TB/DUT/ex_mem_mem_write
add wave -noupdate -color Tomato -label "EX/MEM Mem Read" /Comprehensive_TB/DUT/ex_mem_mem_read

# ============================================================================
# MEMORY STAGE (MEM)
# ============================================================================
add wave -noupdate -divider -height 30 {MEMORY STAGE}
add wave -noupdate -color RoyalBlue -label "Final Mem Addr" -radix hexadecimal /Comprehensive_TB/DUT/final_mem_addr
add wave -noupdate -color MediumBlue -label "Final Mem Write" /Comprehensive_TB/DUT/final_mem_write
add wave -noupdate -color Blue -label "Mem Write Data" -radix hexadecimal /Comprehensive_TB/DUT/mem_write_data
add wave -noupdate -color SteelBlue -label "Mem Data Read" -radix hexadecimal /Comprehensive_TB/DUT/mem_data_read

# ============================================================================
# BRANCH CONTROL
# ============================================================================
add wave -noupdate -divider -height 30 {BRANCH CONTROL}
add wave -noupdate -color HotPink -label "PC Branch Taken" /Comprehensive_TB/DUT/pc_branch_taken
add wave -noupdate -color DeepPink -label "Branch Target" -radix hexadecimal /Comprehensive_TB/DUT/branch_target
add wave -noupdate -color Pink -label "Final Branch Taken" /Comprehensive_TB/DUT/final_branch_taken
add wave -noupdate -color LightPink -label "Final Branch Target" -radix hexadecimal /Comprehensive_TB/DUT/final_branch_target

# ============================================================================
# MEM/WB PIPELINE REGISTER
# ============================================================================
add wave -noupdate -divider -height 30 {MEM/WB REGISTER}
add wave -noupdate -color PaleGreen -label "MEM/WB Instruction" -radix hexadecimal /Comprehensive_TB/DUT/mem_wb_instr
add wave -noupdate -color LightGreen -label "MEM/WB ALU Result" -radix hexadecimal /Comprehensive_TB/DUT/mem_wb_alu_result
add wave -noupdate -color MediumSeaGreen -label "MEM/WB Mem Data" -radix hexadecimal /Comprehensive_TB/DUT/mem_wb_mem_data
add wave -noupdate -color DarkSeaGreen -label "MEM/WB Reg Write En" /Comprehensive_TB/DUT/mem_wb_reg_write_enable

# ============================================================================
# WRITEBACK STAGE (WB)
# ============================================================================
add wave -noupdate -divider -height 30 {WRITEBACK STAGE}
add wave -noupdate -color Lime -label "Write Back Data" -radix hexadecimal /Comprehensive_TB/DUT/write_back_data
add wave -noupdate -color LawnGreen -label "WB Destination" -radix unsigned /Comprehensive_TB/DUT/mem_wb_reg_dest
add wave -noupdate -color Chartreuse -label "WB Source Select" -radix unsigned /Comprehensive_TB/DUT/mem_wb_reg_write_src

# ============================================================================
# INTERRUPT UNIT
# ============================================================================
add wave -noupdate -divider -height 30 {INTERRUPT HANDLING}
add wave -noupdate -color Red -label "Interrupt Trigger" /Comprehensive_TB/DUT/interrupt_trigger
add wave -noupdate -color DarkRed -label "Interrupt Active" /Comprehensive_TB/DUT/interrupt_active
add wave -noupdate -color IndianRed -label "Saved PC" -radix hexadecimal /Comprehensive_TB/DUT/saved_pc
add wave -noupdate -color LightCoral -label "Saved Flags" -radix binary /Comprehensive_TB/DUT/saved_flags
add wave -noupdate -color Crimson -label "Interrupt Vector" -radix hexadecimal /Comprehensive_TB/DUT/interrupt_vector

# ============================================================================
# I/O PORTS
# ============================================================================
add wave -noupdate -divider -height 30 {INPUT/OUTPUT}
add wave -noupdate -color Aquamarine -label "Input Port" -radix hexadecimal /Comprehensive_TB/input_port
add wave -noupdate -color MediumAquamarine -label "Output Port" -radix hexadecimal /Comprehensive_TB/output_port
add wave -noupdate -color Turquoise -label "Output Enable" /Comprehensive_TB/DUT/id_ex_output_en

# ============================================================================
# MEMORY SAMPLE (First 10 locations + Stack area)
# ============================================================================
add wave -noupdate -divider -height 30 {DATA MEMORY (Sample)}
add wave -noupdate -color Lavender -label "MEM[0]" -radix hexadecimal /Comprehensive_TB/DUT/dmem/RAM(0)
add wave -noupdate -color Lavender -label "MEM[1]" -radix hexadecimal /Comprehensive_TB/DUT/dmem/RAM(1)
add wave -noupdate -color Thistle -label "MEM[100]" -radix hexadecimal /Comprehensive_TB/DUT/dmem/RAM(100)
add wave -noupdate -color Plum -label "MEM[254]" -radix hexadecimal /Comprehensive_TB/DUT/dmem/RAM(254)
add wave -noupdate -color Orchid -label "MEM[255]" -radix hexadecimal /Comprehensive_TB/DUT/dmem/RAM(255)

# ============================================================================
# HAZARD DETECTION
# ============================================================================
add wave -noupdate -divider -height 30 {HAZARD DETECTION}
add wave -noupdate -color OrangeRed -label "ID/EX Is Load" /Comprehensive_TB/DUT/id_ex_is_load
add wave -noupdate -color Tomato -label "ID/EX Flush" /Comprehensive_TB/DUT/id_ex_flush_hazard

# ============================================================================
# Configure wave window
# ============================================================================
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 20
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update

# Zoom to show all waveforms
wave zoom full


