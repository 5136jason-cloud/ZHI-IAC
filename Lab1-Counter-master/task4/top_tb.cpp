#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    // Instantiate the counter
    Vtop* top = new Vtop;

    // Initialize waveform tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("counter.vcd");

    //Initialize Vbuddy
    if (vbdOpen() != 1) return -1;
    vbdHeader("Lab 1: Counter");

    // Initialize simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 0;
    top->v = 0;


    // Run simulation for 300 clock cycles
    for (i = 0; i < 300; i++) {

        // Toggle clock and record waveforms
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2*i + clk);
            top->clk = !top->clk;
            top->eval();
        }

        vbdHex(4, 0);
        vbdHex(3, (int(top->bcd) >> 8) & 0xF);
        vbdHex(2, (int(top->bcd) >> 4) & 0xF);
        vbdHex(1, int(top->bcd) & 0xF);
        vbdCycle(i + 1);

        // Change reset and enable signals
        top->rst = (i < 2) | (i == 15);
        top->en = vbdFlag();
        if (Verilated::gotFinish()) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}
