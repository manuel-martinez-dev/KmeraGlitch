# Phase 3: Software Foundation *(Completed)*

## Overview

This phase covers writing the Python capture script that ties the GPIO button to the camera, and configuring it to run automatically on boot as a systemd service.

## What This Phase Delivers

- `scripts/config.py` — settings (GPIO pin, resolution, save path)
- `scripts/capture.py` — listens for button press on GPIO 17, triggers camera capture via picamera2, saves PNG to `/photos/raw`
- `scripts/kmeraglitch.service` — systemd service that auto-starts the capture script on boot

## Prerequisites

- Phase 2 complete (Pi running, camera detected, button wired and tested)
- SSH access to the Pi — connect with `ssh manuma@kmeraglitch.local`

## Steps Completed

1. Verified dependencies already installed on Pi — picamera2 v0.3.34, gpiozero v2.01
2. Created `/photos/raw` on the Pi:
   ```bash
   sudo mkdir -p /photos/raw && sudo chown manuma:manuma /photos/raw
   ```
3. Wrote `config.py` — GPIO pin 17, full resolution (4608×2592), PNG format
4. Wrote `capture.py` — button listener with debounce and concurrent capture protection
5. Wrote `kmeraglitch.service` — systemd service with `WorkingDirectory` set to scripts path
6. Created scripts directory and deployed scripts to the Pi:
   ```bash
   mkdir -p /home/manuma/KmeraGlitch/scripts
   ```
   Then copied files from computer:
   ```bash
   scp scripts/capture.py scripts/config.py scripts/kmeraglitch.service manuma@kmeraglitch.local:/home/manuma/KmeraGlitch/scripts/
   ```
7. Installed and enabled the service:
   ```bash
   sudo cp kmeraglitch.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable kmeraglitch
   sudo systemctl start kmeraglitch
   ```
8. Confirmed auto-start on boot — button triggers capture, PNG saved correctly

## picamera2 API Notes

Verified with official Raspberry Pi picamera2 manual (RP-008156-DS-2, Release 2.0):

- `create_still_configuration` is the method for high-resolution still capture (Section 4.1)
- `capture_file` infers the output format automatically from the file extension — `.png` gives PNG (Section 6.1.4)
- PNG is supported alongside JPEG, BMP and GIF via PIL
- PNG `compress_level` defaults to `1` (fastest compression). Can be tuned 0–9 if smaller file size is needed at cost of CPU time. Not set currently, it can be revisited in Phase 4 or any further.
- Pi 5 supports temporal denoise via a `delay` parameter on mode-switch captures. Not applicable here as we start directly in still mode, not switching from a preview mode.

## Known Issues

- **Hot pixel** — Camera Module 3 has a stuck red pixel at a fixed location. Appears inconsistently. To be corrected in Phase 4 via interpolation in the Ruby pipeline.
- **Camera orientation** — Right now camera hangs by its cable due to case having no proper mount. Hopefully it will be resolved with the 3D printed camera case. Phase 4 pipeline can apply rotation correction if needed (we will see)

## Next Steps

→ [Phase 4: Creative Tools](PHASE_4.md) — Ruby image processing pipeline

## Reference Links

- [picamera2 — Raspberry Pi camera software docs](https://www.raspberrypi.com/documentation/computers/camera_software.html)
- [gpiozero Button](https://gpiozero.readthedocs.io/en/stable/api_input.html)
- [systemd service unit reference](https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html)
