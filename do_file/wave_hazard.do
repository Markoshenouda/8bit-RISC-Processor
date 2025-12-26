onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider -height 30 {CLOCK & CONTROL}
add wave -noupdate -color Gold -label CLK /Hazard_Detection_Test/clk
add wave -noupdate -color Red -label RST /Hazard_Detection_Test/rst
add wave -noupdate -color Orange -label INTERRUPT /Hazard_Detection_Test/interrupt

add wave -noupdate -divider -height 35 {HAZARD DETECTION SIGNALS }
add wave -noupdate -color Red -label "PC_STALL" -height 25 /Hazard_Detection_Test/uut/pc_stall
add wave -noupdate -color Orange -label "IF_ID_STALL" -height 25 /Hazard_Detection_Test/uut/if_id_stall_hazard
add wave -noupdate -color Yellow -label "ID_EX_FLUSH" -height 25 /Hazard_Detection_Test/uut/id_ex_flush_hazard
add wave -noupdate -color Magenta -label "ID_EX_IS_LOAD" /Hazard_Detection_Test/uut/id_ex_is_load
add wave -noupdate -color Cyan -radix unsigned -label "ID_EX_REG_DEST" /Hazard_Detection_Test/uut/id_ex_reg_dest

add wave -noupdate -divider -height 30 {PROGRAM COUNTER}
add wave -noupdate -color Cyan -radix hexadecimal -label "PC_Current" -height 20 /Hazard_Detection_Test/uut/pc_current
add wave -noupdate -color Yellow -radix hexadecimal -label "Instr_Fetched" /Hazard_Detection_Test/uut/instr_fetched
add wave -noupdate -color Orange -label "Branch_Taken" /Hazard_Detection_Test/uut/pc_branch_taken
add wave -noupdate -color Magenta -radix hexadecimal -label "Branch_Target" /Hazard_Detection_Test/uut/branch_target


add wave -noupdate -divider -height 20 {FETCH (IF)}
add wave -noupdate -color Cyan -radix hexadecimal -label "IF_PC" /Hazard_Detection_Test/uut/pc_current
add wave -noupdate -color Yellow -radix hexadecimal -label "IF_Instruction" /Hazard_Detection_Test/uut/instr_fetched

add wave -noupdate -divider -height 20 {IF_ID REGISTER}
add wave -noupdate -color Cyan -radix hexadecimal -label "IF_ID_Instr" /Hazard_Detection_Test/uut/if_id_instr
add wave -noupdate -color Yellow -radix hexadecimal -label "IF_ID_PC" /Hazard_Detection_Test/uut/if_id_pc
add wave -noupdate -color Red -label "IF_ID_Stall" /Hazard_Detection_Test/uut/if_id_stall_hazard

add wave -noupdate -divider -height 20 {DECODE (ID)}
add wave -noupdate -color Magenta -radix unsigned -label "Opcode" /Hazard_Detection_Test/uut/opcode
add wave -noupdate -color Cyan -radix unsigned -label "RA" /Hazard_Detection_Test/uut/ra
add wave -noupdate -color Cyan -radix unsigned -label "RB" /Hazard_Detection_Test/uut/rb
add wave -noupdate -color Yellow -radix hexadecimal -label "Reg_A_Data" /Hazard_Detection_Test/uut/reg_a_data
add wave -noupdate -color Yellow -radix hexadecimal -label "Reg_B_Data" /Hazard_Detection_Test/uut/reg_b_data
add wave -noupdate -color Orange -radix hexadecimal -label "Immediate" /Hazard_Detection_Test/uut/immediate_value
add wave -noupdate -color Green -label "Mem_Read" /Hazard_Detection_Test/uut/mem_read
add wave -noupdate -color Green -label "Is_Load" /Hazard_Detection_Test/uut/is_load

add wave -noupdate -divider -height 20 {ID_EX REGISTER}
add wave -noupdate -color Cyan -radix hexadecimal -label "ID_EX_Instr" /Hazard_Detection_Test/uut/id_ex_instr
add wave -noupdate -color Yellow -radix hexadecimal -label "ID_EX_PC" /Hazard_Detection_Test/uut/id_ex_pc
add wave -noupdate -color Orange -radix hexadecimal -label "ID_EX_Reg_A" /Hazard_Detection_Test/uut/id_ex_reg_a_data
add wave -noupdate -color Orange -radix hexadecimal -label "ID_EX_Reg_B" /Hazard_Detection_Test/uut/id_ex_reg_b_data
add wave -noupdate -color Magenta -radix unsigned -label "ID_EX_RA" /Hazard_Detection_Test/uut/id_ex_ra
add wave -noupdate -color Magenta -radix unsigned -label "ID_EX_RB" /Hazard_Detection_Test/uut/id_ex_rb
add wave -noupdate -color Green -label "ID_EX_Reg_Write" /Hazard_Detection_Test/uut/id_ex_reg_write_enable
add wave -noupdate -color Cyan -label "ID_EX_Is_Load" /Hazard_Detection_Test/uut/id_ex_is_load
add wave -noupdate -color Yellow -radix unsigned -label "ID_EX_Reg_Dest" /Hazard_Detection_Test/uut/id_ex_reg_dest

add wave -noupdate -divider -height 20 {EXECUTE (EX)}
add wave -noupdate -color Orange -radix unsigned -label "ALU_Op" /Hazard_Detection_Test/uut/id_ex_alu_op
add wave -noupdate -color Green -radix hexadecimal -label "ALU_Result" /Hazard_Detection_Test/uut/alu_result

add wave -noupdate -divider {FORWARDING}
add wave -noupdate -color Yellow -radix unsigned -label "Forward_A" /Hazard_Detection_Test/uut/forward_a
add wave -noupdate -color Yellow -radix unsigned -label "Forward_B" /Hazard_Detection_Test/uut/forward_b
add wave -noupdate -color Cyan -radix hexadecimal -label "Forwarded_A" /Hazard_Detection_Test/uut/forwarded_a
add wave -noupdate -color Cyan -radix hexadecimal -label "Forwarded_B" /Hazard_Detection_Test/uut/forwarded_b

add wave -noupdate -divider -height 20 {EX_MEM REGISTER}
add wave -noupdate -color Cyan -radix hexadecimal -label "EX_MEM_Instr" /Hazard_Detection_Test/uut/ex_mem_instr
add wave -noupdate -color Yellow -radix hexadecimal -label "EX_MEM_ALU_Result" /Hazard_Detection_Test/uut/ex_mem_alu_result
add wave -noupdate -color Orange -radix hexadecimal -label "EX_MEM_Reg_B" /Hazard_Detection_Test/uut/ex_mem_reg_b_data
add wave -noupdate -color Green -label "EX_MEM_Reg_Write" /Hazard_Detection_Test/uut/ex_mem_reg_write_enable
add wave -noupdate -color Cyan -radix unsigned -label "EX_MEM_Reg_Dest" /Hazard_Detection_Test/uut/ex_mem_reg_dest

add wave -noupdate -divider -height 20 {MEMORY (MEM)}
add wave -noupdate -color Yellow -radix hexadecimal -label "Mem_Addr" /Hazard_Detection_Test/uut/mem_addr_final
add wave -noupdate -color Orange -radix hexadecimal -label "Mem_Write_Data" /Hazard_Detection_Test/uut/mem_write_data
add wave -noupdate -color Green -radix hexadecimal -label "Mem_Read_Data" /Hazard_Detection_Test/uut/mem_data_read
add wave -noupdate -color Cyan -label "Mem_Read_En" /Hazard_Detection_Test/uut/ex_mem_mem_read
add wave -noupdate -color Magenta -label "Mem_Write_En" /Hazard_Detection_Test/uut/ex_mem_mem_write

add wave -noupdate -divider -height 20 {MEM_WB REGISTER}
add wave -noupdate -color Cyan -radix hexadecimal -label "MEM_WB_Instr" /Hazard_Detection_Test/uut/mem_wb_instr
add wave -noupdate -color Yellow -radix hexadecimal -label "MEM_WB_ALU_Result" /Hazard_Detection_Test/uut/mem_wb_alu_result
add wave -noupdate -color Orange -radix hexadecimal -label "MEM_WB_Mem_Data" /Hazard_Detection_Test/uut/mem_wb_mem_data
add wave -noupdate -color Green -label "MEM_WB_Reg_Write" /Hazard_Detection_Test/uut/mem_wb_reg_write_enable
add wave -noupdate -color Cyan -radix unsigned -label "MEM_WB_Reg_Dest" /Hazard_Detection_Test/uut/mem_wb_reg_dest

add wave -noupdate -divider -height 20 {WRITEBACK (WB)}
add wave -noupdate -color Green -radix hexadecimal -label "Write_Back_Data" -height 20 /Hazard_Detection_Test/uut/write_back_data

add wave -noupdate -divider -height 35 {REGISTER FILE}
add wave -noupdate -color Yellow -radix hexadecimal -label "R0" -height 20 /Hazard_Detection_Test/uut/rf/RF(0)
add wave -noupdate -color Cyan -radix hexadecimal -label "R1" -height 20 /Hazard_Detection_Test/uut/rf/RF(1)
add wave -noupdate -color Orange -radix hexadecimal -label "R2" -height 20 /Hazard_Detection_Test/uut/rf/RF(2)
add wave -noupdate -color Magenta -radix hexadecimal -label "R3" -height 20 /Hazard_Detection_Test/uut/rf/RF(3)

add wave -noupdate -divider -height 30 {CONDITION CODE REGISTER}
add wave -noupdate -color Yellow -radix binary -label "Flags" /Hazard_Detection_Test/uut/current_flags

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
configure wave -valuecolwidth 120
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update

echo ""
echo "Wave Configuration Loaded"
echo ""
