# Notes & Ideas

## Git Workflow

- **Docs (Phase 1-2):** Push directly to `main`
- **Code (Phase 3-4):** Use feature branches (e.g., `feature/camera-capture`, `feature/glitch-pipeline`)

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
