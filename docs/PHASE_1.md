# Phase 1: System Architecture

## Overview

KmeraGlitch is a headless camera system built on Raspberry Pi 5. A physical button triggers photo capture via Python, then a Ruby pipeline processes images into glitch art or ASCII output for use in comics and graphic novels.

> **Hardware note:** Camera Module 3 used is the **standard** version (not Wide). Confirmed from PCB labeling.

## System Diagram

```
[Tactile Button] → GPIO → [Python: picamera2] → RAW photo (4608×2592)
                                                       │
                                                       ▼
                                              /photos/raw/*.jpg
                                                       │
                                                       ▼
                                            [Ruby: MiniMagick pipeline]
                                              ┌────────┼────────┐
                                              ▼        ▼        ▼
                                           Glitch    ASCII     Raw
                                           effect    convert   (clean)
                                              │        │        │
                                              ▼        ▼        ▼
                                        /photos/processed/*.png|*.tiff
```

## Hardware Architecture

| Component | Role |
|-----------|------|
| Raspberry Pi 5 8GB | Main processing unit |
| Camera Module 3 (standard) | Image capture — 11.9MP sensor (4608×2592) |
| Tactile button | Shutter trigger, wired to GPIO |
| 830-point breadboard | Button wiring + future expansion |
| 128GB microSD | Primary storage for OS + photos |
| 27W USB-C power supply | Power |
| Official case + active cooler | Thermal management |
| Camera ribbon cable (included) | Connects Camera Module 3 to Pi CAM0 port |

### GPIO Pin Assignment

```
Tactile Button → GPIO 17 (Pin 11)
Ground         → GND (Pin 9)
```

GPIO 17 is a clean choice — no conflicts with camera or I2C interfaces. Uses internal pull-up resistor configured in gpiozero (no external resistor needed in circuit).

## Software Architecture

### Language Split

| Layer | Language | Libraries | Responsibility |
|-------|----------|-----------|---------------|
| Capture | Python | `picamera2`, `gpiozero` | Button listener, camera control, save RAW |
| Processing | Ruby | `mini_magick` | Glitch effects, ASCII conversion, output formatting |
| OS | Raspberry Pi OS (64-bit) | — | Base system, drivers, file system |

**Note:** MiniMagick chosen over RMagick for lower memory footprint on Pi hardware. Can switch to RMagick if complex operations require direct ImageMagick bindings.

### Why Two Languages?

- **Python** — First-class Pi hardware support (`picamera2` is the official camera library, `gpiozero` for GPIO)
- **Ruby** — Preferred language for developer comfort; MiniMagick for lightweight ImageMagick integration (RMagick available as fallback for complex operations); cleaner syntax for file I/O and batch processing workflows

### Process Flow

1. **Boot:** Python capture script starts as systemd service (auto-start configured in Phase 3)
2. **Idle:** Script listens for GPIO 17 button press (edge detection)
3. **Capture:** Button press triggers `picamera2` → saves high-res JPEG to `/photos/raw/`
4. **Process:** Ruby watcher picks up new files → applies selected effect. (implementation: manual trigger in Phase 4, auto-watch in Phase 5)
5. **Output:** Processed image saved to `/photos/processed/` as print-ready PNG/TIFF or web JPG

## Project Structure

```
KmeraGlitch/
├── docs/                    # Phase documentation
│   ├── PHASE_1.md
│   ├── PHASE_2.md
│   ├── PHASE_3.md
│   ├── PHASE_4.md
│   └── NOTES.md
├── scripts/
│   ├── python/              # Camera + GPIO
│   │   ├── capture.py       # Main capture script
│   │   └── config.py        # Settings (resolution, paths, GPIO pin)
│   └── ruby/                # Image processing
│       ├── process.rb        # Main processing pipeline
│       ├── effects/
│       │   ├── glitch.rb     # Pixel glitch effects
│       │   └── ascii.rb      # ASCII art conversion
│       └── config.rb         # Processing settings
├── photos/                  # Image storage (gitignored)
│   ├── raw/                 # Original captures
│   └── processed/           # Effect output
├── tests/                   # Test images and outputs
├── .gitignore
└── README.md
```

## Image Specifications

### Capture (Input)

- **Resolution:** 4608 × 2592 (11.9MP)
- **Format:** JPEG (high quality, ~3-5MB per image)
- **Color space:** sRGB

### Output (Processed)

| Use Case | Format | Resolution | DPI | Print Size |
|----------|--------|------------|-----|------------|
| Print — glitch effects | PNG or TIFF | 4608 × 2592 | 300 | 15.4" × 8.6" |
| Print — ASCII art | PNG or TIFF | 4608 × 2592 | 600 | 7.7" × 4.3" |
| Web | JPEG | 1920 × 1080 | 72 | — |

DPI is configurable per effect. 300 is the default; 600 recommended for ASCII output where sharp character edges matter.

### Effect Types

- **Glitch:** Datamoshing, bit corruption, channel shifting, pixel sorting
- **ASCII:** Character-mapped image representation (monospace grid)
- **Raw:** Clean photo, no effects (resize/format only)

## Storage Estimates

- **128GB microSD** capacity after OS (~115GB usable)
- ~4MB per RAW capture → ~28,000 photos before full
- Processed outputs vary by format (PNG ~8MB, TIFF ~35MB, JPEG ~1MB)
- Recommendation: Regular transfer to computer, keep SD card under 75% capacity

## Prerequisites for Phase 2

Before starting hardware assembly, ensure you have:
- [x] Camera Module 3 (standard) (ordered/delivered)
- [x] 830-point breadboard kit (ordered/delivered)
- [x] 128GB microSD card (ordered/delivered)
- [x] Monitor + keyboard for initial Pi setup

## Next Steps

→ [Phase 2: Hardware Setup](PHASE_2.md) — Assembly, wiring, and breadboard layout
