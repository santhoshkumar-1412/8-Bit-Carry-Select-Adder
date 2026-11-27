
# 8-Bit Carry Select Adder | Verilog HDL

<p align="center">
  <b>RTL Design | Digital Arithmetic | Functional Verification</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Simulation-Synopsys%20VCS-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Debugging-Synopsys%20Verdi-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Design-8--Bit%20CSA-purple?style=for-the-badge" />
</p>

## 1. Project Overview

This project presents the RTL design and functional verification of an **8-Bit Carry Select Adder (CSA)** using Verilog Hardware Description Language (HDL).

A Carry Select Adder is a high-speed arithmetic circuit designed to reduce carry propagation delay compared with a conventional Ripple Carry Adder.

In this implementation, two 8-bit Ripple Carry Adders calculate the addition results simultaneously:

- The first RCA assumes the carry-in is 0.
- The second RCA assumes the carry-in is 1.
- A multiplexer selects the appropriate sum and carry output based on the actual carry-in signal.

The design accepts two 8-bit binary operands and one carry-in input, producing an 8-bit sum and a final carry-out.

The RTL design is simulated using **Synopsys VCS**, and waveform analysis is performed using **Synopsys Verdi**.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Design Name | 8-Bit Carry Select Adder |
| Design Type | Combinational Logic |
| Architecture | Carry Select Adder |
| Input A | 8-bit |
| Input B | 8-bit |
| Carry Input | 1-bit |
| Sum Output | 8-bit |
| Carry Output | 1-bit |
| Basic Component | Full Adder |
| Internal Architecture | Two 8-bit Ripple Carry Adders |
| HDL | Verilog |
| RTL Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |

## 3. Design Methodology

The Carry Select Adder improves addition speed by computing two possible results in parallel and selecting the correct result using a multiplexer.

### 3.1 Full Adder Design

The Full Adder is the basic building block of the Ripple Carry Adder.

It performs the addition of three single-bit inputs:

- A: First input bit
- B: Second input bit
- Cin: Carry input

**Boolean Expressions:**

Sum:
```text
S = A XOR B XOR Cin
```

Carry:
```text
Cout = (A AND B) OR (A AND Cin) OR (B AND Cin)
```

### 3.2 Ripple Carry Adder (RCA)

An 8-bit Ripple Carry Adder is constructed using eight Full Adder instances connected in series.

The carry output of each Full Adder is connected to the carry input of the next Full Adder.

The first Full Adder receives the external carry-in, while the final Full Adder generates the carry-out.

**Sum Equation:**
```text
S[i] = A[i] XOR B[i] XOR C[i]
```

**Carry Equation:**
```text
C[i+1] = (A[i] AND B[i]) OR (A[i] AND C[i]) OR (B[i] AND C[i])
```

The RCA performs 8-bit binary addition.

### 3.3 Carry Select Architecture

The Carry Select Adder consists of two parallel 8-bit Ripple Carry Adders.

**RCA 0:**

Calculates the addition assuming:

```text
Cin = 0

(S0, Cout0) = A + B + 0
```

**RCA 1:**

Calculates the addition assuming:

```text
Cin = 1

(S1, Cout1) = A + B + 1
```

Both adders operate simultaneously and generate their respective sum and carry outputs.

### 3.4 Multiplexer-Based Selection

The actual carry-in determines which RCA result is selected.

The selection logic is implemented using the conditional operator in Verilog.

**Final Sum Equation:**
```text
S = (Cin == 0) ? S0 : S1
```

**Final Carry Equation:**
```text
Cout = (Cin == 0) ? Cout0 : Cout1
```

This architecture reduces the need to wait for the actual carry to propagate through a single ripple chain before calculating the sum.

### 3.5 Overall Addition Equation

The complete addition operation is represented as:

```text
Result = A + B + Cin
```

The final 9-bit result is represented as:

```text
Result = {Cout, S}
```

## 4. RTL Module Architecture

The project consists of three Verilog modules.

| Module | Functionality |
|---|---|
| `fa` | Implements Full Adder logic |
| `bit8_rca` | Implements an 8-bit Ripple Carry Adder using eight Full Adders |
| `bit8_csa` | Implements the 8-bit Carry Select Adder using two RCAs and multiplexers |
| `bit8_csa_tb` | Testbench for functional verification |

### 4.1 Full Adder Module

The Full Adder generates Sum and Carry outputs using XOR and AND-OR logic.

### 4.2 8-Bit Ripple Carry Adder Module

The module instantiates eight Full Adders with cascaded carry connections.

### 4.3 8-Bit Carry Select Adder Module

The module instantiates two 8-bit Ripple Carry Adders.

Both RCAs calculate the possible results, and the multiplexer selects the appropriate output according to the actual carry-in.

## 5. Repository Structure

```text
8-bit-carry-select-adder/
│
├── bit8_csa.v
│   └── RTL source code
│       ├── Full Adder
│       ├── 8-bit Ripple Carry Adder
│       └── 8-bit Carry Select Adder
│
├── bit8_csa_tb.v
│   └── Functional verification testbench
│
├── screenshots/
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

## 6. Functional Verification

A Verilog testbench is developed to verify the functionality of the 8-bit Carry Select Adder.

The testbench applies four different combinations of input operands and carry-in values at 10 ns intervals.

The simulation results are observed using the `$monitor` system task.

### 6.1 Test Scenarios

| Test Case | A | B | Cin | Expected Sum | Cout |
|:---:|---:|---:|:---:|---:|:---:|
| TC1 | 25 | 30 | 0 | 55 | 0 |
| TC2 | 100 | 50 | 1 | 151 | 0 |
| TC3 | 255 | 1 | 0 | 0 | 1 |
| TC4 | 150 | 100 | 1 | 251 | 0 |

### 6.2 Binary Representation

| Test Case | A | B | Cin | Sum |
|---|---|---|---|---|
| TC1 | 00011001 | 00011110 | 0 | 00110111 |
| TC2 | 01100100 | 00110010 | 1 | 10010111 |
| TC3 | 11111111 | 00000001 | 0 | 00000000 |
| TC4 | 10010110 | 01100100 | 1 | 11111011 |

### 6.3 Expected Simulation Output

```text
Time=0  A=25  B=30  Cin=0 SUM=55  Cout=0
Time=10 A=100 B=50  Cin=1 SUM=151 Cout=0
Time=20 A=255 B=1   Cin=0 SUM=0   Cout=1
Time=30 A=150 B=100 Cin=1 SUM=251 Cout=0
```

**Note:** The simulation uses an 8-bit sum and a separate carry-out bit. Therefore, the result of 255 + 1 is represented as SUM = 0 and Cout = 1.

## 7. Simulation Environment

The design is simulated using Synopsys VCS, and waveform analysis is performed using Synopsys Verdi.

### 7.1 Simulation Workflow

```text
       Verilog RTL Design
               |
               v
        Verilog Testbench
               |
               v
         Synopsys VCS
               |
               v
         RTL Simulation
               |
               v
        Waveform Database
               |
               v
        Synopsys Verdi
               |
               v
        Waveform Analysis
```

### 7.2 VCS Compilation

Compile the RTL source and testbench using:

```bash
vcs -full64 -debug_access+all \
bit8_csa.v \
bit8_csa_tb.v \
-o simv
```

### 7.3 Execute Simulation

Run the compiled simulation executable:

```bash
./simv
```

The testbench executes four test cases and displays the corresponding sum and carry outputs.

### 7.4 VCD Waveform Generation

The testbench generates a VCD waveform database using:

```verilog
initial
begin
    $dumpfile("8BITCARRYSELECTADDER.vcd");
    $dumpvars(0,bit8_csa_tb);
end
```

This enables signal transitions to be recorded during simulation.

### 7.5 Open Waveform in Synopsys Verdi

The generated VCD file can be opened using:

```bash
verdi -vcd 8BITCARRYSELECTADDER.vcd &
```

Alternatively, if an FSDB waveform is generated using the appropriate Verdi PLI integration:

```bash
verdi -ssf inter.fsdb &
```

## 8. Waveform Analysis

Synopsys Verdi is used to inspect and analyze the simulation waveforms.

The following signals are observed:

| Signal | Width | Description |
|---|---:|---|
| `A` | 8 bits | First input operand |
| `B` | 8 bits | Second input operand |
| `Cin` | 1 bit | Carry input |
| `S` | 8 bits | Final sum output |
| `Cout` | 1 bit | Final carry output |

Waveform analysis helps to:

- Observe input and output signal transitions.
- Verify the sum for different operand combinations.
- Verify carry propagation and carry-out generation.
- Analyze the effect of the carry-in selection.
- Debug combinational logic functionality.
- Inspect the design hierarchy and internal signals.

### Simulation Waveform

![8-Bit Carry Select Adder Verdi Waveform](screenshots/verdi_waveform.png)

## 9. Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design implementation |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| VCD / FSDB | Simulation waveform formats |
| Git | Version control |
| GitHub | Source code management and documentation |

## 10. Key Learning Outcomes

Through this project, the following concepts are explored:

- Combinational digital circuit design.
- Full Adder implementation using Boolean expressions.
- 8-bit Ripple Carry Adder architecture.
- Carry Select Adder architecture.
- Parallel computation of carry-dependent results.
- Multiplexer-based result selection.
- Structural RTL modeling using Verilog.
- Testbench development and functional verification.
- RTL simulation using Synopsys VCS.
- Waveform analysis using Synopsys Verdi.

## 11. Future Enhancements

Potential extensions to this project include:

- Extending the Carry Select Adder to 16-bit and 32-bit architectures.
- Comparing Ripple Carry, Carry Select and Carry Lookahead Adders.
- Implementing a variable block-size Carry Select Adder.
- Performing RTL synthesis and hardware area analysis.
- Evaluating propagation delay and critical paths.
- Comparing power, performance and area (PPA).
- Performing gate-level simulation and timing verification.

## 12. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Design | VLSI Engineering

- GitHub: [@santhoshkumar-1412](https://github.com/santhoshkumar-1412) 
- LinkedIn: [@santhosh-kumar-n-a](https://linkedin.com/in/santhosh-kumar-n-a-26b72532b)

## 13. License

This project is intended for educational and learning purposes.

You are welcome to explore, modify and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated with Synopsys VCS | Debugged with Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider starring the repository!
</p>

---

## GitHub Topics

verilog · carry-select-adder · carry-select-adder-design · ripple-carry-adder · digital-design · vlsi · rtl-design · synopsys-vcs · synopsys-verdi · rtl-verification · digital-arithmetic · asic-design
