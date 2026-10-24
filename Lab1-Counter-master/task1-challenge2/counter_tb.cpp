#include "Vcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;
    int pause_cycles = 0;
    bool paused = false;

    Verilated::commandArgs(argc, argv);

    // Instantiate the counter
    Vcounter* top = new Vcounter;

    // Initialize waveform tracing
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("counter.vcd");

    // Initialize simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 0;

    // Run simulation for 300 clock cycles
    for (i = 0; i < 300; i++) {

        // Toggle clock and record waveforms
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2*i + clk);
            top->clk = !top->clk;
            top->eval();
        }

        // Change reset and enable signals
        top->rst = (i < 2) | (i == 20);
        if (!paused && top->count == 0x9) {
            pause_cycles = 3;
            paused = true;
        }

        if (pause_cycles > 0) {
            top->en = 0;
            pause_cycles--;
        } else {
            top->en = 1;
        }

        if (Verilated::gotFinish()) exit(0);
    }

    tfp->close();
    exit(0);
}
