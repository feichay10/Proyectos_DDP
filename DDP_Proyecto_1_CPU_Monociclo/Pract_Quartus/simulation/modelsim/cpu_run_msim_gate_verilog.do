transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {cpu.vo}

vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/PractQuartus/../CPU_base {/home/alumno/Escritorio/PractQuartus/../CPU_base/cpu_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc"  cpu_tb

add wave *
view structure
view signals
run -all
