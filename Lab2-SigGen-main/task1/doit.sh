#!/bin/sh
set -e

# Clean previous build files
rm -rf obj_dir
rm -f sinegen.vcd

# Convert SystemVerilog into C++
verilator -Wall --cc --trace \
    --top-module sinegen \
    sinegen.sv counter.sv rom.sv \
    --exe sinegen_tb.cpp

# Compile the generated C++ model
make -j -C obj_dir -f Vsinegen.mk Vsinegen

# Run simulation
./obj_dir/Vsinegen

