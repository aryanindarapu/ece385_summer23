transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -sv -work work +incdir+. {adders.svo}

vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/adder_testbench.sv}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L gate_work -L work -voptargs="+acc"  adder_testbench

add wave *
view structure
view signals
run -all
