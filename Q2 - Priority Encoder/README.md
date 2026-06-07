# Problem 2 — 8-to-3 Priority Encoder

**Topic:** Combinational Logic · `casez` · Latch-Free Design

---

## Problem Statement

Design an 8-to-3 priority encoder. If multiple input bits are high, the highest-indexed bit wins. Output a `valid` signal that goes low when no input is asserted.

---

## Port Description

| Port    | Direction  | Width | Description                          |
|---------|------------|-------|--------------------------------------|
| `in`    | input      | 8     | 8-bit input                          |
| `out`   | output reg | 3     | Index of highest active bit          |
| `valid` | output reg | 1     | `1` if any bit set, `0` if all zero  |

---

## Files

```
├── encoder.v   ← priority encoder module
└── tb.v        ← self-checking testbench
```

---

## Truth Table (selected cases)

| `in`          | `out` | `valid` |
|---------------|-------|---------|
| `8'b00000001` | `0`   | `1`     |
| `8'b00100000` | `5`   | `1`     |
| `8'b00100001` | `5`   | `1`     | ← bits 5 and 0 set, bit 5 wins |
| `8'b11111111` | `7`   | `1`     |
| `8'b00000000` | —     | `0`     |

---

## Notes

- Uses `casez` with `?` as don't-care bits
- Default assigned at top of always block to avoid latch inference
- All branches assign both `out` and `valid`
