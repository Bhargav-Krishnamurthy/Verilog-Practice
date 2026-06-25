# 100 MHz to 5 MHz Clock Divider in Verilog

A simple Verilog implementation of a synchronous clock divider that reduces a high-frequency input master clock down to a slower, stable output clock signal.

## 📌 Problem Statement
FPGAs and ASICs typically operate on very fast internal crystal oscillators (such as 100 MHz). However, real-world applications or peripheral components (like blinking LEDs, sensors, or lower-speed communication protocols) require much slower clock frequencies to operate correctly. 

Because we cannot physically slow down the hardware's main crystal oscillator, we must use a **Clock Divider** written in digital logic to count master clock pulses and safely generate a new, scaled-down clock output.

## 🧮 How It Works
This specific project acts as a **Divide-by-20** clock divider. 

Using a 100 MHz input clock (which has a period of 10 ns, generated in the testbench via `#5 clk = ~clk;`), the module tracks the incoming pulses using an internal counter. 

The math behind the division follows this hardware formula:
$$\text{Output Frequency} = \frac{\text{Input Frequency}}{2 \times (\text{Target Count} + 1)}$$

Plugging our specific module values into the equation:
$$\text{Output Frequency} = \frac{100\text{ MHz}}{2 \times (9 + 1)} = \frac{100\text{ MHz}}{20} = \mathbf{5\text{ MHz}}$$

Every time the counter hits `9` (which represents 10 full input clock cycles), it resets back to `0` and flips (`toggles`) the state of the output signal (`newclk`). Toggling twice completes one full period of the new 5 MHz clock.

## ⚙️ Key Technical Features
* **Synchronous Reset:** The design includes an active-high `rst` signal to safely initialize the internal counter and output registers to a clean `0` state, preventing uninitialized `X` (unknown) states during simulation.
* **Efficient Bit-Width Calculation:** The counter register (`count`) is sized to 20 bits (`[19:0]`), which is more than enough to handle scaling up to higher values (like a 1 MHz or 100 MHz true 1-second delay) without experiencing bit overflows.
* **Glitch-Free Output:** By using a dedicated register (`output reg newclk`) driving the output instead of raw combinational logic, the output clock remains clean and free of dangerous timing hazards.

## 🚀 How to Run the Simulation in Vivado
1. Add `clockdivider` as your Design Source.
2. Add `clockdivider_tb` as your Simulation Source.
3. Run the Behavioral Simulation.
4. **Important Setup Note:** In the testbench initialization, the reset signal (`rst`) is held high for `#20` ns before falling to `0`. This deliberate delay satisfies the hardware simulator's setup time requirements, completely preventing any simulation race conditions.
