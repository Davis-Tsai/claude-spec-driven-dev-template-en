---
title: Pinout (Pinout / Hardware Contract)
status: Draft
---

# Pinout

> Deterministic anchor: the firmware GPIO configuration and PCB wiring must match this table. Rebuild the firmware based on this.
>
> ⚠️ Example — delete when starting real content: the part numbers/pins in the table are format demonstrations; replace them with your own hardware.

## MCU / Main Controller
- Model: <!-- e.g. ESP32-S3 -->
- Package:

| Pin | Signal Name | Direction | Function/Connected to | Electrical Notes |
|-----|-------------|-----------|-----------------------|------------------|
| GPIO0 |  | IN/OUT | | pull-up/pull-down |
| GPIO1 |  |  |  |  |

## Connectors
| Connector | Pin | Signal | Description |
|-----------|-----|--------|-------------|
| J1 | 1 | VCC | 5V input |
| J1 | 2 | GND |  |
