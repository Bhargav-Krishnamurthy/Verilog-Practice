# Problem 3 — 8-bit Barrel Shifter

**Topic:** Combinational Logic · Mux Tree · Shift Operations

---

## Problem Statement

Design an 8-bit barrel shifter that shifts left or right by 0–7 positions in a single combinational path. Built as a 3-stage mux tree (shift by 4, then 2, then 1). Vacated bits are filled with 0.

---

## Port Description

| Port     | Direction  | Width | Description                  |
|----------|------------|-------|------------------------------|
| `in`     | input      | 8     | Input data                   |
| `shamt`  | input      | 3     | Shift amount (0–7)           |
| `dir`    | input      | 1     | `0` = left, `1` = right      |
| `out`    | output reg | 8     | Shifted result               |

---

## Files

```
├── barrel_shifter.v   ← barrel shifter module
└── tb.v               ← testbench
```

---

## Test Cases

| `in`       | `shamt` | `dir` | `out`      |
|------------|---------|-------|------------|
| `11011100` | `001`   | `0`   | `10111000` |
| `11011100` | `100`   | `0`   | `11000000` |
| `11011100` | `001`   | `1`   | `01101110` |
| `11011100` | `100`   | `1`   | `00001101` |
| `11011100` | `101`   | `0`   | `10000000` |

---

## Notes

- 3-stage mux tree: stage 1 shifts by 4, stage 2 by 2, stage 3 by 1
- No `<<` or `>>` operators used
- Use intermediate regs `s1`, `s2` between stages to avoid blocking assignment bugs
