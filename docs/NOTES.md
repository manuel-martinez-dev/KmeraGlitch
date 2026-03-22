# Notes & Ideas

## Git Workflow

- **Docs (Phase 1-2):** Push directly to `main`
- **Code (Phase 3-4):** Use feature branches (e.g., `feature/camera-capture`, `feature/glitch-pipeline`)

## Camera Module 3 — Protective Case

**Model:** "Raspberry Pi Camera Case for Cam Module 3" by aldmodels
**Source:** https://www.printables.com/model/768693-raspberry-pi-camera-case-for-cam-module-3

- Two-part clip-together case (no screws)
- Files: `raspberry-pi-camera-module-3-back.stl` + `rasberry-pi-camera-camera-module-3-front.stl`
- Compatible with **standard** Camera Module 3 only (confirmed — this is what we have)

**Polish 3D Print Services** (upload both STL files, select PLA/ABS):
- https://send3d.eu — online price calculator, STL upload, InPost shipping
- https://mikroprint.pl — online quote, FDM/SLA
- https://drukujemy3d.pl — FDM/SLA, InPost Paczkomat delivery
- https://3d-innowacje.pl — upload STL, instant quote

## Future Upgrades

### Portable Power (USB-C PD Power Bank)

Currently the Pi runs from a 27W USB-C wall supply (indoor/desk use only). For outdoor shooting, I will need to add a USB-C PD power bank rated 45W+ (e.g., 20,000mAh for ~4-8 hours of use).

**Requirements:**
- Must support USB-C Power Delivery (5V/5A profile)
- Standard 5V/2-3A power banks could cause undervoltage and CPU throttling (need to research more)

**Docs to update when implementing:**
- [ ] **PHASE_1.md** — Add power bank to Hardware Architecture table
- [ ] **PHASE_2.md** — Add portable power setup instructions
- [ ] **SHOPPING.md** — Add power bank to parts list with price
- [ ] **README.md** — Update hardware list
