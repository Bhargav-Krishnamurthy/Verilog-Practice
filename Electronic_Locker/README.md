# Synchronous Electronic Safe (FSM Design)

A Verilog implementation of a secure digital electronic safe controlled by a finite state machine (FSM). The system processes consecutive multi-bit button inputs, unlocking only upon receiving the precise coded sequence while permanently locking out and sounding an alarm if an incorrect input is detected.

---

## 📌 Problem Statement

Design a synchronous digital combination lock that monitors a 2-bit button input vector (`button`). The safe must behave according to the following specifications:

1. **The Sequence:** The safe opens only when the exact sequence of keys **Button A $\rightarrow$ Button B $\rightarrow$ Button A** is entered sequentially on consecutive clock cycles.
   * **Button A** is represented by `2'b01`.
   * **Button B** is represented by `2'b10`.
2. **Lockout Mechanism:** If an incorrect button is pressed at any critical state transition, the system must immediately trigger a persistent **Alarm** state.
3. **Security Lockdown:** Once the alarm is active, the system ignores all subsequent button inputs. It remains frozen until a dedicated hardware **Reset** signal is asserted to restore the safe back to its initial locked state.

---

## 🗺️ State Machine Architecture

The safe is designed using a **Moore-type FSM** with 5 distinct states encoded using a 3-bit register:

* **`S0` (3'b000) - START:** The initial state. The safe is locked. Waiting for the first correct input (Button A).
* **`S1` (3'b001) - STEP 1:** Button A was successfully detected. Waiting for Button B.
* **`S2` (3'b010) - STEP 2:** Button B was successfully detected. Waiting for the final Button A.
* **`S3` (3'b011) - OPEN:** Sequence completed successfully. The `unlocked` signal goes high.
* **`ALARM` (3'b100) - LOCKOUT:** An incorrect key was pressed. The `alarm` signal goes high, and the state machine freezes until `reset` is applied.

### State Transition Table

| Current State | Input (`button`) | Next State | Outputs (`unlocked`, `alarm`) |
| :--- | :--- | :--- | :--- |
| **S0** (START) | `2'b01` (A)<br>`2'b10` (B)<br>`2'b00` (None) | S1<br>ALARM<br>S0 | `0`, `0` |
| **S1** (STEP 1) | `2'b10` (B)<br>`2'b01` (A)<br>`2'b00` (None) | S2<br>S1<br>S1 | `0`, `0` |
| **S2** (STEP 2) | `2'b01` (A)<br>`2'b10` (B)<br>`2'b00` (None) | S3<br>ALARM<br>S2 | `0`, `0` |
| **S3** (OPEN) | Any | S3 | `1`, `0` |
| **ALARM** | Any | ALARM (unless Reset) | `0`, `1` |

---

## 🛠️ Design & Verification Details

* **Language:** Verilog (IEEE 1364-2001 / SystemVerilog compilation targets)
* **Design Pattern:** 2-Process FSM Layout (Separate synchronous state register block and combinational next-state/output logic block).
* **Simulation & Waveforms:** The testbench generates a standard `dump.vcd` file to trace clock cycles, inputs, state transformations, and output signals using standard wave viewers like EPWave or GTKWave.

### Functional Test Scenarios Covered
1. **Successful Entry:** Verifies that entering `2'b01` $\rightarrow$ `2'b10` $\rightarrow$ `2'b01` sets `unlocked = 1`.
2. **Intruder Lockout:** Verifies that pressing a wrong button routes the machine to the `ALARM` state.
3. **Reset Recovery:** Confirms that asserting `reset = 1` safely forces the system from either `OPEN` or `ALARM` states back to `S0`.
