# KmeraGlitch

A DIY creative camera built with Raspberry Pi 5 that captures photos and processes them into pixel glitch or ASCII art for use in comics and graphic novels.

## Core Workflow

1. Press physical button → Python script captures photo
2. Photo saved to SD card (high-res 11.9MP)
3. Ruby script processes image (pixel glitch OR ASCII conversion)
4. Output saved as print-ready PNG/TIFF or web JPG
5. Transfer to computer for further editing/use in comics

## Hardware

- Raspberry Pi 5 8GB
- Camera Module 3 (standard)
- 27W USB-C power supply
- Official case + active cooler
- 32GB microSD with NOOBS
- 128GB microSD
- 830-point breadboard + electronics kit
- Tactile button (shutter trigger)

## Software Stack

- **Python** — Camera control (`picamera2`), GPIO button handling
- **Ruby** — Image processing (glitch effects, ASCII conversion via ImageMagick/RMagick)
- **Raspberry Pi OS** — Base operating system

## Key Features

- Blind shooting (no viewfinder initially)
- Batch processing pipeline
- Multiple effect options (glitch, ASCII, raw)
- Print quality output (300 DPI for comics)
- Optional: Web interface for Steam Deck control (future upgrade)

## Build Phases

1. **System architecture** — Component planning ([Phase 1](docs/PHASE_1.md))
2. **Hardware assembly** — Wiring + setup ([Phase 2](docs/PHASE_2.md))
3. **Software foundation** — Camera setup + basic capture script ([Phase 3](docs/PHASE_3.md))
4. **Creative tools** — Image processing pipeline, glitch + ASCII ([Phase 4](docs/PHASE_4.md))
5. **Integration + testing**
6. **Documentation + creative workflow guide**

## Docs

- [Notes](docs/NOTES.md) — Ideas + observations
