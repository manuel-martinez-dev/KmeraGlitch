# Phase 3: Software Foundation *(Pre-planning)*

## Overview

This phase covers writing the Python capture script that ties the GPIO button to the camera, and configuring it to run automatically on boot as a systemd service.

## What This Phase Delivers

- `python-capture` — listens for button press on GPIO 17, triggers camera capture via picamera2, saves to `/photos/raw/`
- `scripts-pythonConfig` — settings (resolution, save path, GPIO pin)
- systemd service hopefully auto-starts the capture script on boot

## Prerequisites

- Phase 2 complete (Pi running, camera detected, button wired and tested)
- SSH access to the Pi configured (password authentication) — connect with `ssh <username>@kmeraglitch.local`

## Steps

*(To be written when Phase 3 begins)*

1. Install dependencies
2. Write `config.py`
3. Write `capture.py`
4. Test manually
5. Configure systemd service
6. Test auto-start on boot

## Next Steps

→ [Phase 4: Creative Tools](PHASE_4.md) — Ruby image processing pipeline

## Reference Links
I will add some when I read some.
