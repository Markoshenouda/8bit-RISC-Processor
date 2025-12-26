
onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider -height 30 {CLOCK & CONTROL}
add wave -noupdate -color Gold -label CLK /forward_test/clk
add wave -noupdate -color Red -label RST /forward_test/rst
add wave -noupdate -color Orange -label INTERRUPT /forward_test/interrupt
add wave -noupdate -radix hexadecimal -label TIME -format Analog-Step -height 15 -max 1000.0 -min 0.0 /forward_test/uut/pc_current


add wave -noupdate -divider -height 30 {=== FETCH STAGE (IF) ===}
add wave -noupdate -color Cyan -radix hexadecimal -label PC_Current /forward_test/uut/pc_current
add wave -noupdate -color Yellow -radix hexadecimal -label Instr_Fetched /forward_test/uut/instr_fetched
add wave -noupdate -color Magenta -label PC_Stall /forward_test/uut/pc_stall
add wave -noupdate -color Orange -radix hexadecimal -label Interrupt_Vector /forward_test/uut/interrupt_vector

add wave -noupdate -divider -height 30 {=== IF/ID REGISTER ===}
add wave -noupdate -color Cyan -radix hexadecimal -label IF_ID_Instr /forward_test/uut/if_id_instr
add wave -noupdate -color Yellow -radix hexadecimal -label IF_ID_PC /forward_test/uut/if_id_pc
add wave -noupdate -color Red -label IF_ID_Stall /forward_test/uut/if_id_stall_hazard

add wave -noupdate -divider -height 30 {=== DECODE STAGE (ID) ===}
add wave -noupdate -color Magenta -radix unsigned -label Opcode /forward_test/uut/opcode
add wave -noupdate -color Cyan -radix unsigned -label RA /forward_test/uut/ra
add wave -noupdate -color Cyan -radix unsigned -label RB /forward_test/uut/rb
add wave -noupdate -color Yellow -radix hexadecimal -label Reg_A_Data /forward_test/uut/reg_a_data
add wave -noupdate -color Yellow -radix hexadecimal -label Reg_B_Data /forward_test/uut/reg_b_data
add wave -noupdate -color Orange -radix hexadecimal -label Immediate /forward_test/uut/immediate_value


add wave -noupdate -divider {Control Signals}
add wave -noupdate -color Green -label Reg_Write_En /forward_test/uut/reg_write_enable
add wave -noupdate -color Green -radix unsigned -label Reg_Dest /forward_test/uut/reg_dest
add wave -noupdate -color Cyan -label Mem_Read /forward_test/uut/mem_read
add wave -noupdate -color Cyan -label Mem_Write /forward_test/uut/mem_write
add wave -noupdate -color Magenta -label Is_Branch /forward_test/uut/is_branch
add wave -noupdate -color Orange -label Is_Load /forward_test/uut/is_load
add wave -noupdate -color Orange -label Is_Store /forward_test/uut/is_store

add wave -noupdate -divider -height 30 {=== ID/EX REGISTER ===}
add wave -noupdate -color Cyan -radix hexadecimal -label ID_EX_Instr /forward_test/uut/id_ex_instr
add wave -noupdate -color Yellow -radix hexadecimal -label ID_EX_PC /forward_test/uut/id_ex_pc
add wave -noupdate -color Orange -radix hexadecimal -label ID_EX_Reg_A /forward_test/uut/id_ex_reg_a_data
add wave -noupdate -color Orange -radix hexadecimal -label ID_EX_Reg_B /forward_test/uut/id_ex_reg_b_data
add wave -noupdate -color Magenta -radix hexadecimal -label ID_EX_Imm /forward_test/uut/id_ex_imm
add wave -noupdate -color Green -label ID_EX_Reg_Write /forward_test/uut/id_ex_reg_write_enable


add wave -noupdate -divider -height 30 {=== EXECUTE STAGE (EX) ===}


add wave -noupdate -divider {Forwarding Unit}
add wave -noupdate -color Yellow -radix unsigned -label Forward_A /forward_test/uut/forward_a
add wave -noupdate -color Yellow -radix unsigned -label Forward_B /forward_test/uut/forward_b
add wave -noupdate -color Cyan -radix hexadecimal -label Forwarded_A /forward_test/uut/forwarded_a
add wave -noupdate -color Cyan -radix hexadecimal -label Forwarded_B /forward_test/uut/forwarded_b


add wave -noupdate -divider {ALU}
add wave -noupdate -color Orange -radix unsigned -label ALU_Op /forward_test/uut/id_ex_alu_op
add wave -noupdate -color Green -radix hexadecimal -label ALU_Result /forward_test/uut/alu_result
add wave -noupdate -color Magenta -label ALU_Z /forward_test/uut/alu_z
add wave -noupdate -color Magenta -label ALU_N /forward_test/uut/alu_n
add wave -noupdate -color Magenta -label ALU_C /forward_test/uut/alu_c
add wave -noupdate -color Magenta -label ALU_V /forward_test/uut/alu_v


add wave -noupdate -divider {Condition Code Register}
add wave -noupdate -color Yellow -radix binary -label Current_Flags /forward_test/uut/current_flags
add wave -noupdate -color Cyan -label Flag_Z /forward_test/uut/current_flags(0)
add wave -noupdate -color Cyan -label Flag_N /forward_test/uut/current_flags(1)
add wave -noupdate -color Cyan -label Flag_C /forward_test/uut/current_flags(2)
add wave -noupdate -color Cyan -label Flag_V /forward_test/uut/current_flags(3)


add wave -noupdate -divider -height 30 {=== EX/MEM REGISTER ===}
add wave -noupdate -color Cyan -radix hexadecimal -label EX_MEM_Instr /forward_test/uut/ex_mem_instr
add wave -noupdate -color Yellow -radix hexadecimal -label EX_MEM_ALU_Result /forward_test/uut/ex_mem_alu_result
add wave -noupdate -color Orange -radix hexadecimal -label EX_MEM_Reg_B /forward_test/uut/ex_mem_reg_b_data
add wave -noupdate -color Magenta -radix hexadecimal -label EX_MEM_Mem_Addr /forward_test/uut/ex_mem_mem_addr
add wave -noupdate -color Green -label EX_MEM_Reg_Write /forward_test/uut/ex_mem_reg_write_enable
add wave -noupdate -color Cyan -label EX_MEM_Mem_Read /forward_test/uut/ex_mem_mem_read
add wave -noupdate -color Cyan -label EX_MEM_Mem_Write /forward_test/uut/ex_mem_mem_write


add wave -noupdate -divider -height 30 {=== MEMORY STAGE (MEM) ===}
add wave -noupdate -color Yellow -radix hexadecimal -label Mem_Addr_Final /forward_test/uut/mem_addr_final
add wave -noupdate -color Orange -radix hexadecimal -label Mem_Write_Data /forward_test/uut/mem_write_data
add wave -noupdate -color Green -radix hexadecimal -label Mem_Data_Read /forward_test/uut/mem_data_read

add wave -noupdate -divider -height 30 {=== MEM/WB REGISTER ===}
add wave -noupdate -color Cyan -radix hexadecimal -label MEM_WB_Instr /forward_test/uut/mem_wb_instr
add wave -noupdate -color Yellow -radix hexadecimal -label MEM_WB_ALU_Result /forward_test/uut/mem_wb_alu_result
add wave -noupdate -color Orange -radix hexadecimal -label MEM_WB_Mem_Data /forward_test/uut/mem_wb_mem_data
add wave -noupdate -color Magenta -radix hexadecimal -label MEM_WB_Imm /forward_test/uut/mem_wb_imm
add wave -noupdate -color Green -label MEM_WB_Reg_Write /forward_test/uut/mem_wb_reg_write_enable
add wave -noupdate -color Cyan -radix unsigned -label MEM_WB_Reg_Dest /forward_test/uut/mem_wb_reg_dest

add wave -noupdate -divider -height 30 {=== WRITEBACK STAGE (WB) ===}
add wave -noupdate -color Green -radix hexadecimal -label Write_Back_Data /forward_test/uut/write_back_data


add wave -noupdate -divider -height 30 {=== REGISTER FILE ===}
add wave -noupdate -color Yellow -radix hexadecimal -label R0 /forward_test/uut/rf/RF(0)
add wave -noupdate -color Cyan -radix hexadecimal -label R1 /forward_test/uut/rf/RF(1)
add wave -noupdate -color Orange -radix hexadecimal -label R2 /forward_test/uut/rf/RF(2)
add wave -noupdate -color Magenta -radix hexadecimal -label {R3 (SP)} /forward_test/uut/rf/RF(3)

add wave -noupdate -divider -height 30 {=== STACK POINTER ===}
add wave -noupdate -color Green -radix hexadecimal -label SP_Current /forward_test/uut/sp_current
add wave -noupdate -color Yellow -label SP_Inc /forward_test/uut/ex_mem_sp_inc
add wave -noupdate -color Orange -label SP_Dec /forward_test/uut/ex_mem_sp_dec

add wave -noupdate -divider -height 30 {=== BRANCH UNIT ===}
add wave -noupdate -color Cyan -label Branch_Taken /forward_test/uut/pc_branch_taken
add wave -noupdate -color Yellow -radix hexadecimal -label Branch_Target /forward_test/uut/branch_target
add wave -noupdate -color Orange -label EX_MEM_Is_Branch /forward_test/uut/ex_mem_is_branch

add wave -noupdate -divider -height 30 {=== INTERRUPT UNIT ===}
add wave -noupdate -color Red -label Interrupt_Trigger /forward_test/uut/interrupt_trigger
add wave -noupdate -color Yellow -label Interrupt_Active /forward_test/uut/interrupt_active
add wave -noupdate -color Orange -radix hexadecimal -label Saved_PC /forward_test/uut/saved_pc
add wave -noupdate -color Cyan -radix binary -label Saved_Flags /forward_test/uut/saved_flags

add wave -noupdate -divider -height 30 {=== INPUT/OUTPUT ===}
add wave -noupdate -color Green -radix hexadecimal -label Output_Port /forward_test/output_port
add wave -noupdate -color Yellow -radix hexadecimal -label Input_Port /forward_test/input_port


add wave -noupdate -divider -height 30 {=== HAZARD DETECTION ===}
add wave -noupdate -color Red -label PC_Stall /forward_test/uut/pc_stall
add wave -noupdate -color Orange -label IF_ID_Stall /forward_test/uut/if_id_stall_hazard
add wave -noupdate -color Yellow -label ID_EX_Flush /forward_test/uut/id_ex_flush_hazard


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
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
