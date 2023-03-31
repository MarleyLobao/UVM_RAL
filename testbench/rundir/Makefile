PATHS = +incdir+../../rtl/ \
        +incdir+../src/ \
        +incdir+../src/apb_env \
        +incdir+../src/ral_env \

IFS = ../src/apb_env/apb_if.svh

PKGS = ../src/traffic_pkg.svh

TOP = ../src/traffic_top.sv

#MODEL = ../src/external.cpp

RTL = ../../rtl/traffic.v

RUN_ARGS_COMMON = -access +r -input ../scripts/shm.tcl \
		  +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

sim:
	#@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o test.so
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) -sv_lib test.so \
    +UVM_TESTNAME=traffic_reg_rw_test $(RUN_ARGS_COMMON)

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ simvision* xcelium.d simv.daidir *.so *.o *.err

gui:
	#@g++ -g -fPIC -Wall -std=c++0x $(MODEL) -shared -o test.so
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) -sv_lib test.so \
    +UVM_TESTNAME=traffic_reg_rw_test $(RUN_ARGS_COMMON) -gui
