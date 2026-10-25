#!/bin/sh

set -e

rm -rf obj_dir
rm -f sigdelay.vcd

verilator -Wall --cc --trace --top-module sigdelay sigdelay.sv counter.sv ram.sv --exe sigdelay_tb.cpp

make -j -C obj_dir -f Vsigdelay.mk Vsigdelay

./obj_dir/Vsigdelay