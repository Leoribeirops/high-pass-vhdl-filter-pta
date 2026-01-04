# VHDL High-Pass Filter – Pan-Tompkins Algorithm

## Overview

This repository provides a **VHDL implementation of a high-pass filter**, corresponding to the **second stage of the Pan-Tompkins algorithm**, which is extensively used for **QRS complex detection** in electrocardiogram (ECG) signals.

The high-pass filter is responsible for removing **baseline wander** and very low-frequency components caused by respiration, electrode motion, and patient movement, while preserving the rapid variations associated with the QRS complex.

---

## Mathematical Model

The discrete-time high-pass filter implemented in this project is defined by the following difference equation:

\[
y[n] = y[n-1] - \frac{x[n]}{32} + x[n-16] - x[n-17] + \frac{x[n-32]}{32}
\]

Where:
- \( x[n] \) is the input ECG sample  
- \( y[n] \) is the filtered output sample  

The coefficients \( \frac{1}{32} \) are powers of two, enabling efficient **hardware realization via arithmetic right shifts**, which is particularly advantageous for low-power and resource-constrained designs.

---

## Hardware Design Characteristics

- **Language**: VHDL  
- **Architecture**: Fully synchronous  
- **Arithmetic**: Fixed-point  
- **Filter type**: IIR high-pass filter  
- **Scaling factors**: Implemented using right shifts (division by 32)  
- **Delays**: Up to 32 input samples  
- **Optimization focus**:
  - Low hardware complexity
  - Efficient register usage
  - Elimination of baseline drift
  - Suitability for FPGA and ASIC implementations

---

## Project Structure

```text
.
├── HPF_biowear.vhd   # VHDL implementation of the high-pass └── README.md         # Project documentation
