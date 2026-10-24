#!/bin/bash

verilator -Wall --cc --trace \
    --top-module top \
    top.sv counter.sv bin2bcd.sv \
    --exe top_tb.cpp

make -j -C obj_dir/ -f Vtop.mk Vtop

obj_dir/Vtop