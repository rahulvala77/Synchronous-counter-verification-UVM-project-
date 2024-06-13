# Makefile for counter project
RTL= ../rtl/dut_top.sv
work= work #library name
TEST= ../test/counter_test.sv
INC = +incdir+../test/ +incdir+../env/ +incdir+../test/seq/ 
INF = ../env/counter_interface.sv
PKG = ../test/counter_pkg.sv
TOP1 = ../top/counter_top.sv
TOP = counter_top

COVOP = -coverage -novopt -sva -sv_seed random
VSIMOPT= +access +r -sva
VSIMBATCH1= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov1.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH2= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov2.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH3= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov3.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH4= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov4.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH5= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov5.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH6= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov6.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH7= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov7.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH8= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov8.ucdb;add wave -r /*;run -all; exit"
VSIMBATCH9= -c -do "coverage save -onexit -directive -cvg -codeall counter_cov9.ucdb;add wave -r /*;run -all; exit"

help:
	@echo ===========================================================================================================
	@echo " clean   	=>  clean the earlier log and intermediate files.       							"
	@echo " sv_cmp    	=>  Create library and compile the code.                   	  			"
	@echo " TC1       	=>  To compile and run the testcase1 in batch mode.									" 
	@echo " TC2        	=>  To compile and run the testcase2 in batch mode.									" 
	@echo " TC3       	=>  To compile and run the testcase3 in batch mode.									"
	@echo " TC4        	=>  To compile and run the testcase4 in batch mode.									" 
	@echo " TC5       	=>  To compile and run the testcase5 in batch mode.									"
	@echo " regress 	=>  clean, compile and run testcases TC1 and TC2,TC3,TC4,TC5 TC6 TC7 in batch mode.	" 
	
	@echo " report_12   =>  To merge coverage reports for testcases TC1,TC2,TC3, TC4 and TC5 "												   
	@echo " cov_report  =>  To view the coverage report.												           	"
	@echo ===========================================================================================================

cmp:
	vlib $(work)
	vmap $(work)
	vlog -coveropt 3 +cover +acc -work $(work) $(RTL) $(INF) $(PKG) $(TOP1) $(INC)

test1:
	vsim -novopt top +TEST1


up:
	vsim -novopt $(TOP) +counter_up_test

down:
	vsim -novopt $(TOP) +counter_down_test

freset:
	vsim -novopt $(TOP) +counter_reset_test

rollover:
	vsim -novopt $(TOP) +counter_rollover_test

rollback:
	vsim -novopt $(TOP) +counter_rollback_test
	
	
TC1:
	vsim $(VSIMBATCH1) $(COVOP) -wlf "wave_file1.wlf" -l test1.log work.counter_top +UVM_TESTNAME=counter_up_test
	vcover report -html counter_cov1.ucdb

	
TC2:
	vsim $(VSIMBATCH2) $(COVOP) -wlf "wave_file2.wlf" -l test2.log work.counter_top +UVM_TESTNAME=counter_down_test
	vcover report -html counter_cov2.ucdb

TC3:
	vsim $(VSIMBATCH3) $(COVOP) -wlf "wave_file3.wlf" -l test3.log work.counter_top +UVM_TESTNAME=counter_reset_test 	
	vcover report -html counter_cov3.ucdb

TC4:
	vsim $(VSIMBATCH4) $(COVOP) -wlf "wave_file4.wlf" -l test4.log work.counter_top +UVM_TESTNAME=counter_rollover_test
	vcover report -html counter_cov4.ucdb

TC5:
	vsim $(VSIMBATCH5) $(COVOP) -wlf "wave_file5.wlf" -l test5.log work.counter_top +UVM_TESTNAME=counter_rollback_test
	vcover report -html counter_cov5.ucdb

TC6:
	vsim $(VSIMBATCH6) $(COVOP) -wlf "wave_file6.wlf" -l test6.log work.counter_top +UVM_TESTNAME=counter_up_down_test
	vcover report -html counter_cov6.ucdb

TC7:
	vsim $(VSIMBATCH7) $(COVOP) -wlf "wave_file7.wlf" -l test7.log work.counter_top +UVM_TESTNAME=counter_load_test
	vcover report -html counter_cov7.ucdb

TC8:
	vsim $(VSIMBATCH8) $(COVOP) -wlf "wave_file8.wlf" -l test8.log work.counter_top +UVM_TESTNAME=counter_one_up_second_down_test
	vcover report -html counter_cov8.ucdb

TC9:
	vsim $(VSIMBATCH9) $(COVOP) -wlf "wave_file9.wlf" -l test9.log work.counter_top +UVM_TESTNAME=counter_one_down_second_up_test
	vcover report -html counter_cov9.ucdb



report_12:
	vcover merge counter_cov.ucdb counter_cov1.ucdb counter_cov2.ucdb counter_cov3.ucdb counter_cov4.ucdb counter_cov5.ucdb counter_cov6.ucdb counter_cov7.ucdb counter_cov8.ucdb counter_cov9.ucdb 
	vcover report -details -html counter_cov.ucdb

regress: 	clean cmp TC1 TC2 TC3 TC4 TC5 TC6 TC7 TC8 TC9 report_12
 
report:
	 firefox covhtmlreport/index.html&
	
clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* fifo_cov* *.wlf *.ucdb modelsim.ini
	rm -r work
	clear

code:
	vcover report -details -html counter_cov.ucdb



