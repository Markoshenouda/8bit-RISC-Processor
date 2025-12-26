onerror {resume}
quietly WaveActivateNextPane {} 0

# ============================================
# 1. CLOCK & CONTROL
# ============================================
add wave -noupdate -divider -height 30 "CLOCK & CONTROL"
add wave -noupdate -color Yellow -label CLK /tb_interrupt/clk
add wave -noupdate -color Red -label RST /tb_interrupt/rst
add wave -noupdate -color Cyan -label PC_STALL /tb_interrupt/uut/pc_stall

# ============================================
# 2. INTERRUPT SIGNALS
# ============================================
add wave -noupdate -divider -height 30 "INTERRUPT SIGNALS"
add wave -noupdate -color Red -label INT_PIN /tb_interrupt/interrupt
add wave -noupdate -color {Orange Red} -label INT_TRIGGER /tb_interrupt/uut/interrupt_trigger
add wave -noupdate -color Pink -label INT_ACTIVE /tb_interrupt/uut/interrupt_active
add wave -noupdate -color Magenta -radix hexadecimal -label SAVED_PC /tb_interrupt/uut/saved_pc
add wave -noupdate -color Magenta -radix binary -label SAVED_FLAGS /tb_interrupt/uut/saved_flags

# ============================================
# 3. PROGRAM COUNTER & BRANCHING
# ============================================
add wave -noupdate -divider -height 30 "PROGRAM COUNTER"
add wave -noupdate -color {Cornflower Blue} -radix hexadecimal -label PC /tb_interrupt/uut/pc_current
add wave -noupdate -color {Medium Blue} -radix hexadecimal -label INT_VECTOR /tb_interrupt/uut/interrupt_vector
add wave -noupdate -color {Sky Blue} -label BRANCH_TAKEN /tb_interrupt/uut/final_branch_taken
add wave -noupdate -color {Sky Blue} -radix hexadecimal -label BRANCH_TARGET /tb_interrupt/uut/final_branch_target

add wave -noupdate -divider "Branch Details"
add wave -noupdate -color {Light Blue} -label MEM_BRANCH /tb_interrupt/uut/mem_branch_taken
add wave -noupdate -color {Light Blue} -radix hexadecimal -label MEM_TARGET /tb_interrupt/uut/mem_branch_target
add wave -noupdate -color {Steel Blue} -label EX_BRANCH /tb_interrupt/uut/pc_branch_taken
add wave -noupdate -color {Steel Blue} -radix hexadecimal -label EX_TARGET /tb_interrupt/uut/branch_target

# ============================================
# 4. STACK POINTER
# ============================================
add wave -noupdate -divider -height 30 "STACK POINTER"
add wave -noupdate -color Green -radix hexadecimal -label SP /tb_interrupt/uut/sp_current
add wave -noupdate -color {Spring Green} -label SP_INC /tb_interrupt/uut/ex_mem_sp_inc
add wave -noupdate -color {Forest Green} -label SP_DEC /tb_interrupt/uut/ex_mem_sp_dec
add wave -noupdate -color {Yellow Green} -label INT_SP_DEC /tb_interrupt/uut/interrupt_sp_dec

# ============================================
# 5. PIPELINE STAGES - INSTRUCTIONS
# ============================================
add wave -noupdate -divider -height 30 "PIPELINE - INSTRUCTIONS"
add wave -noupdate -color {Slate Blue} -radix hexadecimal -label IF_INSTR /tb_interrupt/uut/instr_fetched
add wave -noupdate -color {Medium Slate Blue} -radix hexadecimal -label IF_ID_INSTR /tb_interrupt/uut/if_id_instr
add wave -noupdate -color {Dark Slate Blue} -radix hexadecimal -label ID_EX_INSTR /tb_interrupt/uut/id_ex_instr
add wave -noupdate -color {Blue Violet} -radix hexadecimal -label EX_MEM_INSTR /tb_interrupt/uut/ex_mem_instr
add wave -noupdate -color {Dark Violet} -radix hexadecimal -label MEM_WB_INSTR /tb_interrupt/uut/mem_wb_instr

# ============================================
# 6. PIPELINE CONTROL SIGNALS
# ============================================
add wave -noupdate -divider -height 30 "PIPELINE CONTROL"
add wave -noupdate -color Orange -label IF_ID_STALL /tb_interrupt/uut/if_id_stall_hazard
add wave -noupdate -color {Dark Orange} -label ID_EX_FLUSH /tb_interrupt/uut/id_ex_flush_hazard

add wave -noupdate -divider "Branch/Call/Ret Flags"
add wave -noupdate -color Cyan -label IS_BRANCH /tb_interrupt/uut/id_ex_is_branch
add wave -noupdate -color {Dark Cyan} -label IS_CALL /tb_interrupt/uut/id_ex_is_call
add wave -noupdate -color {Light Cyan} -label IS_RET /tb_interrupt/uut/ex_mem_is_ret
add wave -noupdate -color Aquamarine -label IS_RTI /tb_interrupt/uut/ex_mem_is_rti

add wave -noupdate -divider "Load/Store Flags"
add wave -noupdate -color {Saddle Brown} -label IS_LOAD /tb_interrupt/uut/id_ex_is_load
add wave -noupdate -color {Sandy Brown} -label IS_STORE /tb_interrupt/uut/id_ex_is_store

# ============================================
# 7. REGISTER FILE
# ============================================
add wave -noupdate -divider -height 30 "REGISTER FILE"
add wave -noupdate -color Gold -radix hexadecimal -label R0 /tb_interrupt/uut/rf/RF(0)
add wave -noupdate -color {Light Goldenrod} -radix hexadecimal -label R1 /tb_interrupt/uut/rf/RF(1)
add wave -noupdate -color Khaki -radix hexadecimal -label R2 /tb_interrupt/uut/rf/RF(2)
add wave -noupdate -color {Dark Khaki} -radix hexadecimal -label "R3 (SP)" /tb_interrupt/uut/rf/RF(3)

add wave -noupdate -divider "Register Control"
add wave -noupdate -color Wheat -label REG_WRITE /tb_interrupt/uut/mem_wb_reg_write_enable
add wave -noupdate -color Tan -radix unsigned -label REG_DEST /tb_interrupt/uut/mem_wb_reg_dest
add wave -noupdate -color {Burly Wood} -radix hexadecimal -label WRITE_DATA /tb_interrupt/uut/write_back_data

# ============================================
# 8. ALU & FLAGS
# ============================================
add wave -noupdate -divider -height 30 "ALU & FLAGS"
add wave -noupdate -color Purple -radix hexadecimal -label ALU_A /tb_interrupt/uut/forwarded_a
add wave -noupdate -color Plum -radix hexadecimal -label ALU_B /tb_interrupt/uut/forwarded_b
add wave -noupdate -color Orchid -radix hexadecimal -label ALU_RESULT /tb_interrupt/uut/alu_result
add wave -noupdate -color Violet -radix unsigned -label ALU_OP /tb_interrupt/uut/id_ex_alu_op

add wave -noupdate -divider "Flags (VNZC)"
add wave -noupdate -color Magenta -radix binary -label FLAGS /tb_interrupt/uut/current_flags
add wave -noupdate -color Pink -label FLAG_WRITE /tb_interrupt/uut/id_ex_flag_write_enable
add wave -noupdate -color {Hot Pink} -radix binary -label FLAG_MASK /tb_interrupt/uut/id_ex_flag_write_mask

# ============================================
# 9. DATA FORWARDING
# ============================================
add wave -noupdate -divider -height 30 "DATA FORWARDING"
add wave -noupdate -color Coral -radix unsigned -label FWD_A /tb_interrupt/uut/forward_a
add wave -noupdate -color {Light Coral} -radix unsigned -label FWD_B /tb_interrupt/uut/forward_b
add wave -noupdate -color Salmon -radix hexadecimal -label EX_MEM_ALU /tb_interrupt/uut/ex_mem_alu_result
add wave -noupdate -color {Light Salmon} -radix hexadecimal -label MEM_WB_DATA /tb_interrupt/uut/write_back_data

# ============================================
# 10. MEMORY INTERFACE
# ============================================
add wave -noupdate -divider -height 30 "MEMORY INTERFACE"
add wave -noupdate -color {Olive Drab} -label MEM_READ /tb_interrupt/uut/ex_mem_mem_read
add wave -noupdate -color {Dark Olive Green} -label MEM_WRITE /tb_interrupt/uut/final_mem_write
add wave -noupdate -color {Yellow Green} -radix hexadecimal -label MEM_ADDR /tb_interrupt/uut/final_mem_addr
add wave -noupdate -color {Chartreuse} -radix hexadecimal -label MEM_WRITE_DATA /tb_interrupt/uut/final_mem_data
add wave -noupdate -color {Lawn Green} -radix hexadecimal -label MEM_READ_DATA /tb_interrupt/uut/mem_data_read

add wave -noupdate -divider "Interrupt Memory Write"
add wave -noupdate -color Red -label INT_MEM_WR /tb_interrupt/uut/interrupt_mem_write
add wave -noupdate -color {Orange Red} -radix hexadecimal -label INT_MEM_ADDR /tb_interrupt/uut/interrupt_mem_addr
add wave -noupdate -color {Indian Red} -radix hexadecimal -label INT_MEM_DATA /tb_interrupt/uut/interrupt_mem_data

# ============================================
# 11. STACK MEMORY (0xF0 - 0xFF)
# ============================================
add wave -noupdate -divider -height 30 "STACK MEMORY"
add wave -noupdate -color {Pale Green} -radix hexadecimal -label M_FF /tb_interrupt/uut/dmem/RAM(255)
add wave -noupdate -color {Light Green} -radix hexadecimal -label M_FE /tb_interrupt/uut/dmem/RAM(254)
add wave -noupdate -color {Medium Sea Green} -radix hexadecimal -label M_FD /tb_interrupt/uut/dmem/RAM(253)
add wave -noupdate -color {Sea Green} -radix hexadecimal -label M_FC /tb_interrupt/uut/dmem/RAM(252)

# ============================================
# 12. I/O PORTS
# ============================================
add wave -noupdate -divider -height 30 "INPUT/OUTPUT"
add wave -noupdate -color Turquoise -radix hexadecimal -label INPUT_PORT /tb_interrupt/input_port
add wave -noupdate -color {Dark Turquoise} -radix hexadecimal -label OUTPUT_PORT /tb_interrupt/output_port
add wave -noupdate -color Aqua -label OUTPUT_EN /tb_interrupt/uut/id_ex_output_en
add wave -noupdate -color {Cadet Blue} -label INPUT_EN /tb_interrupt/uut/id_ex_input_en

# ============================================
# ANALOG VIEW FOR PC (OPTIONAL - LOOKS COOL!)
# ============================================
add wave -noupdate -divider -height 30 "PC ANALOG VIEW"
add wave -noupdate -color {Cornflower Blue} -radix hexadecimal -format Analog-Step -min 0 -max 255 -label PC_ANALOG /tb_interrupt/uut/pc_current

# ============================================
# CONFIGURATION
# ============================================
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {115000 ps} 0} {{Cursor 2} {235000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 200
configure wave -valuecolwidth 80
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update

# Zoom to interesting regions
WaveRestoreZoom {100000 ps} {250000 ps}