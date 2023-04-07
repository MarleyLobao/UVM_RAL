# UVM_Traffic_RAL
This repository organizes the ChipVerify website code so that it is executable in a verification environment that uses the Register Abstraction Layer (RAL).

[UVM Register Model Example source code from ChipVerify](https://www.chipverify.com/uvm/uvm-register-model-example)

<br />
The model implemented for the abstraction layer of the registers is represented according to **Figure 1**, as well as its buses (CTL, STAT, TIMER_0 and TIMER_1) and respective fields.

#### Figure 1 - Register Abstraction Layer Model
![](https://www.chipverify.com/images/uvm/design.png)
##### Source: <https://www.chipverify.com/images/uvm/design.png>
<br /><br />

The result of the *traffic_reg_rw_test* is illustrated in the waveform in Figure 2.

#### Figure 2 - Waveforms from traffic_reg_rw_test
![](https://www.chipverify.com/images/uvm/waves/reg_model_example_wave1.png)
##### a) ChipVerify - Source: <https://www.chipverify.com/images/uvm/waves/reg_model_example_wave1.png>
<hr>

![](docs/waveforms.jpg)
##### b) Author
<br />
