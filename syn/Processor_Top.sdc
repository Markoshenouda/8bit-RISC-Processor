###################################################################

# Created by write_sdc on Wed Dec 24 20:14:14 2025

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[7]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[6]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[5]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[4]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[3]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {input_port[0]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports interrupt]
set_load -pin_load 0.1 [get_ports {output_port[7]}]
set_load -pin_load 0.1 [get_ports {output_port[6]}]
set_load -pin_load 0.1 [get_ports {output_port[5]}]
set_load -pin_load 0.1 [get_ports {output_port[4]}]
set_load -pin_load 0.1 [get_ports {output_port[3]}]
set_load -pin_load 0.1 [get_ports {output_port[2]}]
set_load -pin_load 0.1 [get_ports {output_port[1]}]
set_load -pin_load 0.1 [get_ports {output_port[0]}]
create_clock [get_ports clk]  -period 20  -waveform {0 10}
set_clock_uncertainty 0.1  [get_clocks clk]
set_clock_transition -max -rise 0.05 [get_clocks clk]
set_clock_transition -min -rise 0.05 [get_clocks clk]
set_clock_transition -max -fall 0.05 [get_clocks clk]
set_clock_transition -min -fall 0.05 [get_clocks clk]
set_false_path   -from [get_ports rst]
set_false_path   -from [get_ports interrupt]
set_input_delay -clock clk  4  [get_ports interrupt]
set_input_delay -clock clk  4  [get_ports {input_port[7]}]
set_input_delay -clock clk  4  [get_ports {input_port[6]}]
set_input_delay -clock clk  4  [get_ports {input_port[5]}]
set_input_delay -clock clk  4  [get_ports {input_port[4]}]
set_input_delay -clock clk  4  [get_ports {input_port[3]}]
set_input_delay -clock clk  4  [get_ports {input_port[2]}]
set_input_delay -clock clk  4  [get_ports {input_port[1]}]
set_input_delay -clock clk  4  [get_ports {input_port[0]}]
set_output_delay -clock clk  4  [get_ports {output_port[7]}]
set_output_delay -clock clk  4  [get_ports {output_port[6]}]
set_output_delay -clock clk  4  [get_ports {output_port[5]}]
set_output_delay -clock clk  4  [get_ports {output_port[4]}]
set_output_delay -clock clk  4  [get_ports {output_port[3]}]
set_output_delay -clock clk  4  [get_ports {output_port[2]}]
set_output_delay -clock clk  4  [get_ports {output_port[1]}]
set_output_delay -clock clk  4  [get_ports {output_port[0]}]
