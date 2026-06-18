# 4-Bit Wrap-Around Priority Encoder

A synthesizable, fully combinational 4-bit priority encoder implemented in Verilog that supports a dynamic starting search index with wrap-around capability.

---

## Problem Statement

In standard priority encoders, bit 0 always holds the highest priority. In high-performance hardware schedulers (like round-robin arbiters), the priority needs to start dynamically from a specific pointer and wrap around when it reaches the highest bit.

### Specifications
* **Inputs:**
  * `in` (4 bits): Request lines.
  * `start_idx` (2 bits): The bit index where the priority search begins.
* **Outputs:**
  * `final_idx` (2 bits): The index of the first active request found.
  * `valid` (1 bit): Asserted high if any bit in `in` is active.

### Scan Order Logic
The circuit scans the input vector from right to left starting at `start_idx`. If it reaches bit 3 without finding an active request, it wraps around to bit 0 and continues scanning up to `start_idx - 1`.

---

## Example Trace

Given the following test case:
* `in` = `4'b1101` (Bits 0, 2, and 3 are active)
* `start_idx` = `2'b01` (Start searching at index 1)

**Search Sequence:**
1. Check Index 1 $\rightarrow$ `in[1]` is `0` (Skip)
2. Check Index 2 $\rightarrow$ `in[2]` is `1` (**Match Found!**)

**Output:** `final_idx = 2`, `valid = 1`.

---

## Hardware Architecture & Optimization

Instead of using sequential loops that generate long propagation delays ($T_{pd}$), this design uses a **vector duplication and shifting trick** to keep the circuit fully parallel and fast:

1. **Duplication:** Concatenate the input vector with itself to form an 8-bit bus (`{in, in}`). This layout straightens the wrap-around loop into a linear line.
2. **Alignment:** Use a variable bit-slice (`+:`) to cut out a 4-bit window starting exactly at `start_idx`.
3. **Fixed Priority:** Feed the aligned window into a basic fixed-priority encoder to find the local offset.
4. **Re-alignment:** Add the local offset back to `start_idx` to calculate the absolute index.

---

