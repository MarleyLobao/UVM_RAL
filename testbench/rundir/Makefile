PATHS = +incdir+../../rtl/ \
        +incdir+../src/ \
        +incdir+../src/apb_env \
        +incdir+../src/ral_env \

IFS = ../src/apb_env/apb_if.svh

PKGS = ../src/traffic_pkg.svh

TOP = ../src/traffic_top.sv

RTL = ../../rtl/traffic.v

RUN_ARGS_COMMON = -access +rw -input ../scripts/shm.tcl \
		  +uvm_set_config_int=*,recording_detail,1 -coverage all -covoverwrite

frontdoor:
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) \
    +UVM_TESTNAME=traffic_reg_rw_test $(RUN_ARGS_COMMON) $(ARGS)

backdoor_ro:
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) \
    +UVM_TESTNAME=traffic_reg_ro_backdoor_test -define BACKDOOR_MODE $(RUN_ARGS_COMMON) $(ARGS)

backdoor_rw:
	xrun -64bit -uvm $(PATHS) $(PKGS) $(IFS) $(RTL) $(TOP) \
    +UVM_TESTNAME=traffic_reg_rw_backdoor_test -define BACKDOOR_MODE $(RUN_ARGS_COMMON) $(ARGS)

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ simvision* xcelium.d simv.daidir *.so *.o *.err .reinvoke.sim
