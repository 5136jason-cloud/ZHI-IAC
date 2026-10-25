# Lab 2 — Signal Generation and Capture

## Overview

This laboratory investigates the implementation of memory components in SystemVerilog and their use in signal-processing systems.

The laboratory begins by using a ROM as a waveform lookup table. A counter generates the ROM address, allowing the stored samples to be read sequentially to produce a periodic waveform. The design is then extended to generate two signals with a configurable phase difference using a dual-port ROM.

The final task uses a dual-port RAM to store microphone samples received from Vbuddy. Reading from an earlier RAM address produces a delayed version of the captured signal.

---

## Contents

| Section | Description | Logbook |
|---|---|---|
| Task 1 | Generate a waveform using a counter and ROM | [Task 1 logbook](task1/readme.md) |
| Task 1 Challenge | Control waveform frequency using the Vbuddy rotary encoder | [Task 1 Challenge](task1/readme.md#challenge--variable-frequency-generation) |
| Task 2 | Generate two waves with a configurable phase difference | [Task 2 logbook](task2/readme.md) |
| Task 3 | Capture and delay a microphone signal using RAM | [Task 3 logbook](task3/readme.md) |

---

## Repository Structure

```text
Lab2-SigGen-main/
├── readme.md
├── Lab_2.md
├── Lab_2.pdf
├── Vbuddy_functions.md
├── images/
│
├── task1/
│   ├── counter.sv
│   ├── rom.sv
│   ├── sinegen.sv
│   ├── sinegen.py
│   ├── sinerom.mem
│   ├── sinegen_tb.cpp
│   ├── doit.sh
│   └── readme.md
│
├── task2/
│   ├── counter.sv
│   ├── rom.sv
│   ├── sinegen.sv
│   ├── sinegen_tb.cpp
│   ├── doit.sh
│   └── readme.md
│
└── task3/
    ├── counter.sv
    ├── ram.sv
    ├── sigdelay.sv
    ├── sigdelay_tb.cpp
    ├── doit.sh
    └── readme.md
```

Generated build files inside `obj_dir/` and waveform files such as `*.vcd` are not shown in this overview.

---

## Conclusion

Lab 2 demonstrated how counters and memory components can be combined to construct practical signal-processing systems.

ROM was used as a waveform lookup table for fixed signal generation, while dual-port ROM allowed two phase-shifted signals to be produced simultaneously. RAM was then used as a circular audio buffer, making it possible to store live microphone samples and retrieve delayed samples at the same time.

The laboratory also reinforced the use of parameterised SystemVerilog modules, hierarchical hardware design, C++ testbenches and Vbuddy as an interactive simulation interface.