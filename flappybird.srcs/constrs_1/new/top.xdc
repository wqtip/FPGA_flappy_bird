
set_property IOSTANDARD LVCMOS33 [get_ports i_flap]
set_property IOSTANDARD LVCMOS33 [get_ports new_game]

set_property PACKAGE_PIN T17 [get_ports i_flap]
set_property PACKAGE_PIN W19 [get_ports new_game]


# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
# Red
set_property PACKAGE_PIN G19 [get_ports {o_r[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_r[0]}]
set_property PACKAGE_PIN H19 [get_ports {o_r[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_r[1]}]
set_property PACKAGE_PIN J19 [get_ports {o_r[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_r[2]}]
set_property PACKAGE_PIN N19 [get_ports {o_r[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_r[3]}]

# Green
set_property PACKAGE_PIN J17 [get_ports {o_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_g[0]}]
set_property PACKAGE_PIN H17 [get_ports {o_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_g[1]}]
set_property PACKAGE_PIN G17 [get_ports {o_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_g[2]}]
set_property PACKAGE_PIN D17 [get_ports {o_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_g[3]}]

# Blue
set_property PACKAGE_PIN N18 [get_ports {o_b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_b[0]}]
set_property PACKAGE_PIN L18 [get_ports {o_b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_b[1]}]
set_property PACKAGE_PIN K18 [get_ports {o_b[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_b[2]}]
set_property PACKAGE_PIN J18 [get_ports {o_b[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_b[3]}]

# Sync signals
set_property PACKAGE_PIN P19 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]
set_property PACKAGE_PIN R19 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]
set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


#seven seg display

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]

set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]









