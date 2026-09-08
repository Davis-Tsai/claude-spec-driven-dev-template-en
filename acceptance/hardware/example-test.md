---
title: Hardware Acceptance / Measurement Procedures
status: Draft
---

# Hardware Acceptance Test Procedures

> Hardware cannot "run unit tests", so standardized measurement procedures serve as the acceptance basis instead.
> Each item maps to one PRD requirement, and is repeatable and recordable.

## HW-AC-001: Power Consumption Verification (maps to NFR-003)
- **Equipment**: DC power supply, ammeter
- **Steps**:
  1. Apply 5.0V input.
  2. Enter active mode and measure the active current.
  3. Enter sleep mode and measure the sleep current.
- **Pass criteria**: active current ≤ ___ mA; sleep current ≤ ___ µA.
- **Measured value**: ______ (tester / date)

## HW-AC-002: Communication Timing Verification (maps to timing.md)
- **Equipment**: logic analyzer / oscilloscope
- **Steps**: measure the I2C SCL frequency and signal integrity.
- **Pass criteria**: 400 kHz ± 5%, no noticeable glitch.
- **Measured value**: ______

## HW-AC-003: Boot Ready Time
- **Steps**: measure the time from power-on until the firmware reports ready.
- **Pass criteria**: < ___ ms.
- **Measured value**: ______
