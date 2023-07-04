transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/subtracter_9.sv}
vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/shifter.sv}
vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/multiplier.sv}
vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/full_adder.sv}
vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/control.sv}
vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/adder_9.sv}

vlog -sv -work work +incdir+C:/Users/ary/Desktop/ece385_summer23/lab3 {C:/Users/ary/Desktop/ece385_summer23/lab3/mult_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  mult_testbench

add wave *
view structure
view signals
run 2000 ns
