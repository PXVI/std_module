# std_module
------------------------
A simplified one stop RTL library for all the basic Verilog modules.


### Contents ( List of modules )
- [X] Basic Gates
  - [X] AND
  - [X] OR
  - [X] NOT
  - [X] NOR
  - [X] NAND
  - [X] XOR
  - [X] XNOR
- [X] Logic Modules
  - [X] Multiplexer 2x1
  - [X] Multiplexer Nx1 ( Module Script )
  - [X] DeMultiplexer 1x2
  - [X] DeMultiplexer 1xN ( Module Script )
  - [X] Encoder NxM
  - [X] Decoder MxN
- [ ] Arithematic Modules
  - [ ] Half Adder
  - [ ] Full Adder
  - [ ] Half Subtractor
  - [ ] Full Subtractor
- [ ] Sequential Modules
  - [ ] Left Shifter ( SISO )
  - [ ] Right Shifter ( SISO )
  - [ ] Cyclic Shifter ( SISO )
  - [ ] Parallel Load Serial Shifter ( PISO )
  - [ ] Barrel Shifter
  - [ ] Linear Feedback Shift Register ( LFSR )
- [ ] Buffer Modules
  - [ ] Synchronous FIFO
  - [ ] Asynchronous FIFO
    - [X] Asynchronous FIFO ( v1 )


#### Note :
All the modules here are designed in the behavioural format of the RTL code. It is quiet unlikely that you will find any hardcore structural code in here. If there are any, I'll make sure to mention it in this list here, so its easier to keep track of.
Some modules, such as the FIFOs have a few variations in them with respect to the specification used. In that case, you can either use the design doc as reference ( which may be avialable in the directory itself ) or you can look at the description of the module provided in the comments of the module source file. 
