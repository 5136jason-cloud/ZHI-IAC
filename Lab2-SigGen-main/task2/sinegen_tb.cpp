#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"

#include "vbuddy.cpp"

#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char **argv, char **env) {
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);

    // Initialize top-level Verilog instance
    Vsinegen* top = new Vsinegen;

    // Initialize trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("sinegen.vcd");

    // Initialize Vbuddy
    if (vbdOpen() != 1) return(-1);
    vbdHeader("L2T1: SigGen");

    // Initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->offset = 0;

    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {

        // Toggle clock and dump waveforms
        for (tick = 0; tick < 2; tick++) {
            tfp->dump(2*simcyc + tick);
            top->clk = !top->clk;
            top->eval();
        }

        // Read rotary encoder value
        top->offset = vbdValue();

        // Plot ROM output
        vbdPlot(int(top->data1), 0, 255);
        vbdPlot(int(top->data2), 0, 255);
        vbdCycle(simcyc);

        // Quit if finished or 'q' pressed
        if (Verilated::gotFinish() || vbdGetkey() == 'q')
            exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}
