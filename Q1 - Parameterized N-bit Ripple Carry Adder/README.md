# Problem 1 — Parameterized N-bit Ripple Carry Adder

**Topic:** Combinational Logic · Structural Verilog · `generate-for` · Module Instantiation  
**Difficulty:** Beginner–Intermediate  


---

## Problem Statement

Design a **parameterized N-bit ripple carry adder (RCA)** in Verilog using structural style.

You must implement it as two separate modules:

1. `full_adder` — a 1-bit full adder (the building block)
2. `rca` — the top-level N-bit adder that instantiates `full_adder` N times using a `generate-for` loop

The default value of N is 8, but the design must work correctly for any positive integer N without any other code changes.

---

## Module Specifications

### Module 1: `full_adder`

| Port  | Direction | Width | Description             |
|-------|-----------|-------|-------------------------|
| `a`   | input     | 1     | First operand bit       |
| `b`   | input     | 1     | Second operand bit      |
| `cin` | input     | 1     | Carry-in                |
| `sum` | output    | 1     | Sum bit                 |
| `cout`| output    | 1     | Carry-out               |

Boolean equations (implement these exactly using `assign`):
```
sum  = a XOR b XOR cin
cout = (a AND b) OR (b AND cin) OR (a AND cin)
```

### Module 2: `rca`

| Port    | Direction | Width   | Description                        |
|---------|-----------|---------|------------------------------------|
| `a`     | input     | `N`     | First operand                      |
| `b`     | input     | `N`     | Second operand                     |
| `cin`   | input     | 1       | Carry-in to bit 0                  |
| `sum`   | output    | `N`     | N-bit sum result                   |
| `cout`  | output    | 1       | Final carry-out from bit N-1       |

Parameters:

| Parameter | Default | Description         |
|-----------|---------|---------------------|
| `N`       | `8`     | Bit width of adder  |

---

## Design Constraints

- **No behavioral addition allowed.** You cannot write `assign {cout, sum} = a + b + cin;`. The entire point of this problem is structural instantiation.
- The `full_adder` module must be in a **separate file** (`full_adder.v`).
- The top-level `rca` module must use a **`generate-for` loop** with a `genvar` to instantiate `full_adder`.
- The generate block must have a **label** (e.g., `begin : adder_chain`).
- Internal carry wires must be declared as `wire [N:0] carry` where `carry[0] = cin` and `carry[N] = cout`.
- No `always` blocks anywhere — this is purely combinational logic using `assign` and structural instantiation.

---

## What You Need to Implement

```
rca/
├── rca.v              ← N-bit ripple carry adder (uses generate-for)
├── tb.v               ← Testbench (see requirements below)
├── README.md          ← this file
```

---

## Testbench Requirements

Write a self-checking testbench `rca_tb.v` that tests the following cases. For each, compute the expected result inside the testbench and use `$error` if the DUT output doesn't match.

| Test Case                        | a        | b        | cin | Expected sum | Expected cout |
|----------------------------------|----------|----------|-----|--------------|---------------|
| Basic addition                   | 8'd15    | 8'd10    | 0   | 8'd25        | 0             |
| Overflow (carry propagates out)  | 8'hFF    | 8'h01    | 0   | 8'h00        | 1             |
| Addition with carry-in           | 8'd100   | 8'd100   | 1   | 8'd201       | 0             |
| Zero + Zero                      | 8'h00    | 8'h00    | 0   | 8'h00        | 0             |
| Max + Max (double overflow)      | 8'hFF    | 8'hFF    | 1   | 8'hFF        | 1             |
| Carry-in only                    | 8'h00    | 8'h00    | 1   | 8'h01        | 0             |

Your testbench must:
- Print `PASS` or `FAIL` for each test case with `$display`
- Print a final summary: how many tests passed out of total
- Use `$dumpfile` and `$dumpvars` so you can view waveforms

---

## Expected Waveform Behavior

For the overflow test case (`8'hFF + 8'h01, cin=0`):

```
Time  a        b        cin   sum      cout
0     11111111 00000001  0   00000000   1
```

The carry ripples from bit 0 all the way to bit 7 and exits as `cout=1`. In a post-synthesis timing simulation, you'll see this ripple happen with small incremental delays — that's why it's called a *ripple* carry adder.

---

## Concepts Covered

**`generate-for` and `genvar`**  
A `genvar` is not a real wire or reg — it only exists at elaboration time. The `generate-for` loop tells the synthesizer to create N copies of the `full_adder` module with different connections, resolved before simulation starts.

**Structural vs. Behavioral Verilog**  
Behavioral: `assign {cout, sum} = a + b + cin;` — hides hardware, lets the synthesizer decide.  
Structural: explicitly instantiate each gate or module — you control the exact hardware structure.  
This problem forces structural style so you understand what an adder *actually is* in silicon.

**Carry Chain**  
The `wire [N:0] carry` array is the ripple. `carry[0]` is your cin. Each `full_adder` instance writes its cout to `carry[i+1]`, which becomes the next FA's cin. `carry[N]` is your final cout.

**Why RCA is slow**  
Bit N cannot compute its sum until bit N-1 produces its carry, which waits on bit N-2, and so on. This is O(N) propagation delay — the fundamental limitation of ripple carry. A 32-bit RCA in a real process node has ~10× more delay than a Carry Look-Ahead Adder.

---
