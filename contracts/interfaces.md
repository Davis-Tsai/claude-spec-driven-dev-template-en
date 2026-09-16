---
title: Interfaces Contract
status: Draft
---

# Interfaces

> The project's software "deterministic anchor". **Non-web/DB projects (embedded, protocol, CLI…) often have no relational DB or REST API** —
> in that case mark `data-schema.sql` and `api.openapi.yaml` `N/A`, and put the **interface truth here** (packet / serial / command protocol).
> Conversely, web projects can use SQL/OpenAPI and mark this file `N/A`. **Use whichever applies.**

> ⚠️ Example — delete when starting real content: the rows below are format demonstrations.

## 1. Packet / Message Formats
| Packet/Message | Direction | Type/ID | Layout (fields, types, units) | Notes |
|----------------|-----------|---------|-------------------------------|-------|
| e.g. status report | A→B | 0x01 | `[hdr][type][val_lo][val_hi]`; val=int16 ×10 | little-endian |

## 2. Serial / Command Protocol
> e.g. UART/NMEA `$XXX,...*<XOR>`; list the command set, baud rate, format, replies.

## 3. API Conventions (if any)
> External programming interface (function signatures / returns / error codes), host-side API.

## 4. Units & State Definitions
> Unified units (e.g. deg/s ×10), state enums (IDLE/RUN/DONE…), byte order (big/little-endian).
