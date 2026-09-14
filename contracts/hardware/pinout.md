---
title: Pinout (Hardware Contract)
status: Draft
---

# Pinout

> Deterministic anchor: the firmware GPIO/peripheral configuration and PCB wiring must match this table. Rebuild the firmware based on this.
>
> ⚠️ Example — delete when starting real content: the part numbers/pins in the table are format demonstrations; replace them with your own hardware.

## Why record the "internal configuration"
The same pin can be muxed to different functions/modes by the part's internal registers (AF number, GPIO push-pull/open-drain, pull-up/down, speed, voltage level…).
The **configurations at both ends of a connection must be compatible** (e.g., one end is SPI SCK output while the other is SCLK input; an open-drain end needs a pull-up on the other end).
**Record the internal configuration of every pin used; for cross-part connections, also list both ends' configurations in the "Connection Configuration Matrix" for one-shot verification.**

## MCU / Main Controller
- Model: <!-- e.g. ESP32-S3 / STM32... -->
- Package:

| Pin | Signal Name | Direction | Connected to | Internal Config (register/mode) | Electrical Notes |
|-----|-------------|-----------|--------------|----------------------------------|------------------|
| e.g. PB10 | SPI2_SCK | OUT | Sensor.SCLK | AF5(SPI2), push-pull, no pull, high speed | 3V3 |
| e.g. PC3 | BRAKE_DRV | OUT | Relay.IN1 | GPIO output, **open-drain**, no pull | needs pull-up on other end/external; 5V-tolerant |
| e.g. PB7 | I2C1_SDA | Bidir | Sensor.SDA | AF4(I2C1), **open-drain** | needs pull-up Rp on the line |

## Connectors
| Connector | Pin | Signal | Description |
|-----------|-----|--------|-------------|
| J1 | 1 | VCC | 5V input |
| J1 | 2 | GND |  |

## Connection Configuration Matrix
> **One-shot verification channel**: one row per "component↔component / board↔board" connection, **listing both ends' pins and their respective internal configurations**, and checking compatibility.
> This pairs up the per-part configurations above for cross-checking, so the two ends can't silently disagree with nowhere to verify.

| Conn ID | Signal/Protocol | End A (part.pin) | End A config | End B (part.pin) | End B config | Compatibility check |
|---------|-----------------|------------------|--------------|------------------|--------------|---------------------|
| C-01 | SPI CLK | MCU.PB10 | AF5(SPI2) SCK, push-pull output | Sensor.SCLK | SPI slave clock input | ✅ master-out/slave-in, Mode3 consistent |
| C-02 | Actuation | MCU.PC3 | GPIO open-drain output, active-low | Relay.IN1 | opto input, active-low, module has built-in pull-up | ✅ OD + other-end pull-up compatible |
| C-03 | I2C SDA | MCU.PB7 | AF4(I2C1), open-drain | Sensor.SDA | I2C, open-drain | ✅ both OD, needs line pull-up Rp |

> **Check focus**: direction compatibility (out↔in), voltage-level compatibility (3V3/5V, open-drain needs pull-up), protocol-mode consistency (e.g. SPI CPOL/CPHA, I2C address/speed), drive strength/speed.
