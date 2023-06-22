transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/lookahead_adder_pg.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/router.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/reg_17.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/lookahead_adder.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/HexDriver.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/control.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/lookahead_adder_4.sv}
vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/adder2.sv}

vlog -sv -work work +incdir+C:/ece385_summer23/lab2/adders {C:/ece385_summer23/lab2/adders/adder_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  adder_testbench

add wave *
view structure
view signals
run 10000 ns
