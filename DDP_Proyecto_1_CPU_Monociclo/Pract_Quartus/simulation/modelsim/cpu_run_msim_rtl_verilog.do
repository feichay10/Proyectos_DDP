transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/CPU_base {/home/alumno/Escritorio/CPU_base/uc.v}
vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/CPU_base {/home/alumno/Escritorio/CPU_base/cpu.v}
vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/CPU_base {/home/alumno/Escritorio/CPU_base/cd.v}
vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/CPU_base {/home/alumno/Escritorio/CPU_base/alu.v}
vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/CPU_base {/home/alumno/Escritorio/CPU_base/memprog.v}
vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/CPU_base {/home/alumno/Escritorio/CPU_base/componentes.v}

vlog -vlog01compat -work work +incdir+/home/alumno/Escritorio/PractQuartus/../CPU_base {/home/alumno/Escritorio/PractQuartus/../CPU_base/cpu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  cpu_tb

add wave *
view structure
view signals
run -all
