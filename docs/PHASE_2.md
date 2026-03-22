# Phase 2: Hardware Setup *(Completed)*

## Overview

This phase covers assembling the Raspberry Pi 5, connecting the Camera Module 3, and wiring the shutter button on the breadboard.

## What You Need

From [Phase 1 prerequisites](PHASE_1.md#prerequisites-for-phase-2):
- Raspberry Pi 5 8GB
- Camera Module 3 Wide (120° FOV) + ribbon cable
- Official Raspberry Pi 5 Case (with integrated fan cooler) **or** standalone Active Cooler
- 27W USB-C power supply
- 128GB microSD card
- 830-point breadboard + electronics kit (includes tactile button, jumper wires)
- Monitor + keyboard (for initial setup only) — requires **micro-HDMI to HDMI** cable or adapter (Pi 5 does not have a standard HDMI port)

## Safety Notes

- Touch a grounded metal object before handling the Pi to discharge static electricity
- Work on a non-conductive surface
- Don't force connectors — if it doesn't fit easily, check orientation
- Handle the camera ribbon cable carefully — avoid sharp bends or creases

## Step 1: Prepare the microSD Card

1. Download **Raspberry Pi Imager** from https://www.raspberrypi.com/software/
2. Insert the **128GB microSD** card into your computer
3. In the Imager, select:
   - **Device:** Raspberry Pi 5
   - **OS:** Raspberry Pi OS (64-bit) — recommended
   - **Storage:** Your 128GB microSD
4. Click the gear icon or "Edit Settings" to pre-configure:
   - Hostname: `kmeraglitch`
   - Enable SSH (with password authentication)
   - Set username/password
   - Configure Wi-Fi credentials (optional but recommended for headless access later)
   - Set locale settings (timezone, keyboard layout)
5. Click "Write" and wait for completion
6. Eject the card safely

## Step 2: Assemble the Case + Cooler

There are two supported cooling setups. Use whichever you have:

---

### Option A: Official Raspberry Pi 5 Case (with integrated fan)

The official case has a fan built into the lid. No separate cooler installation needed.

1. **Place the Pi into the case bottom:**
   - Insert the Pi board into the case bottom
   - Ensure all ports (USB, Ethernet, HDMI) are accessible through the case cutouts
   - **Don't attach the lid yet** — leave the camera port (CAM0) accessible until the ribbon cable is connected

2. **Fan connection:**
   - The case fan connects to the **FAN header** (4-pin white connector near the GPIO header, labeled "FAN")
   - Connect it before closing the lid

3. **Close the case** after the ribbon cable is routed (see Step 3)

---

### Option B: Standalone Active Cooler (without official case)

1. **Attach the active cooler to the Pi 5 board:**
   - Remove the protective film from the thermal pad on the cooler
   - Align the cooler over the CPU (large chip in center of board)
   - Press down firmly and secure with the provided clips/screws
   - Connect the fan cable to the **FAN header** (4-pin white connector near the GPIO header, labeled "FAN")

## Step 3: Connect the Camera Module

The Camera Module 3 connects to the **CAM0** port (located on the board edge between the HDMI ports and the Ethernet port).

### Connection Steps

1. **Unlock the CAM0 connector:**
   - Gently pull the black plastic clip upward (about 2mm)
   - The clip should slide up, not come off completely

2. **Insert the ribbon cable:**
   - Hold the cable with **contacts (silver/gold pins) facing toward the PCB board**
   - The **blue tab faces outward** (away from the board)
   - Insert the cable fully into the connector slot
   - Push straight in — don't angle it

3. **Lock the connector:**
   - Push the black plastic clip back down firmly
   - You should hear/feel a small click
   - Gently tug the cable — it should not pull out

4. **Route the cable:**
   - Thread the cable through the case slot
   - Avoid sharp bends (minimum bend radius: ~10mm)
   - Leave some slack to prevent tension on the connector

**Visual reference for cable orientation:**
```
Side view of CAM0 port:
┌──────────────────────┐
│  Raspberry Pi Board  │
│                      │
│     ┌─[CAM0]─┐      │
│     │ ▓▓▓▓▓▓ │◄──── Black clip (locks cable)
│     │ ░░░░░░ │◄──── Ribbon cable (contacts facing down)
│     └────────┘      │
│      Blue tab       │
│      faces up ▲     │
└──────────────────────┘
```

## Step 4: Wire the Shutter Button

### Components Needed

- 1x tactile push button (from electronics kit)
- 2x male-to-female jumper wires (from electronics kit)

### Understanding the Button

Tactile buttons have 4 pins but only 2 electrical circuits:
- Pins on the **same side** are internally connected
- Pressing the button connects **opposite sides**
- Placing it across the breadboard's center channel ensures proper operation

### Breadboard Layout

```
Breadboard center channel (gap):
═══════════════════════════════

    Row A    Row B
    ┌──┐     ┌──┐
    │●●│─────│●●│  ← Tactile button (4 pins, spans center)
    └──┘     └──┘
     │        │
     │        └──────── Jumper to Pi Pin 11 (GPIO 17)
     │
     └────────────────── Jumper to Pi Pin 9 (GND)

When button is pressed: GPIO 17 connects to GND
When released: GPIO 17 is pulled high (via software pull-up)
```

### Pi GPIO Pin Reference

```
Raspberry Pi 5 GPIO Header (top view, USB ports facing down):
┌─────────────────────────────────┐
│  (1) 3.3V         (2) 5V       │
│  (3) GPIO2        (4) 5V       │
│  (5) GPIO3        (6) GND      │
│  (7) GPIO4        (8) GPIO14   │
│  (9) GND ◄────────(10) GPIO15  │ ◄ We use Pin 9
│  (11) GPIO17 ◄────(12) GPIO18  │ ◄ We use Pin 11
│  (13) GPIO27      (14) GND     │
│  (15) GPIO22      (16) GPIO23  │
│  ... (continues)               │
└─────────────────────────────────┘
```

### Wiring Steps

1. **Place the button on the breadboard:**
   - Insert the button so it **spans the center channel**
   - Press it firmly so all 4 pins are seated
   - Note which rows the pins occupy (e.g., rows 10 and 12)

2. **Connect GND (Pin 9):**
   - Take a **male-to-female jumper wire**
   - Plug the **female end** onto **Pi GPIO Pin 9** (GND) — 5th pin down on the left column
   - Insert the **male end** into the breadboard in the **same row as the top pins** of the button, in an empty hole in the main grid (columns a–e side)

3. **Connect GPIO 17 (Pin 11):**
   - Take another **male-to-female jumper wire**
   - Plug the **female end** onto **Pi GPIO Pin 11** (GPIO 17) — 6th pin down on the left column
   - Insert the **male end** into the breadboard in the **same row as the bottom pins** of the button, in an empty hole in the main grid (columns f–j side)

4. **Verify connections:**
   - Button should span center channel
   - One wire on the a–e side (top half), one wire on the f–j side (bottom half)
   - Both wires go into the **main grid** — not the power rail strips at the board edges
   - No resistor needed — software configures internal pull-up

## Step 5: First Boot

1. **Insert the 128GB microSD card** into the Pi (slot is on the underside)
2. **Connect peripherals:**
   - Monitor via **micro-HDMI to HDMI** cable or adapter (use **HDMI0** port — closest to USB-C power)
   - USB keyboard
3. **Power on:**
   - Plug in the **27W USB-C power supply**
   - Green LED should flash (SD card activity)
   - Red LED should be solid (power)
4. **Wait for boot:**
   - First boot takes 1-2 minutes
   - Pi OS desktop should appear
   - Complete any first-run setup dialogs (if not pre-configured)

### Verify the Camera

Open a terminal (Ctrl+Alt+T or click terminal icon) and run:

```bash
# Install camera tools if not present
sudo apt update
sudo apt install -y libcamera-apps

# Check if camera is detected
rpicam-hello --list-cameras
```

> **Note:** Newer versions of Raspberry Pi OS (libcamera-apps 1.11.1+) rename all commands from `libcamera-*` to `rpicam-*`. Use `rpicam-hello`, `rpicam-still` etc. throughout.

**Expected output:**
```
Available cameras
-----------------
0 : imx708 [4608x2592] (/base/axi/pcie@120000/rp1/i2c@80000/imx708@1a)
    Modes: 'SRGGB10_CSI2P' : 1536x864 [120.00 fps]
                             2304x1296 [56.25 fps]
                             4608x2592 [14.35 fps]
```

**Take a test photo:**
```bash
rpicam-still -o test.jpg
```

A preview window should appear for 5 seconds, then save `test.jpg` to your home directory.

### Verify GPIO Button

Test the button connection with a Python one-liner:

```bash
# Test button press detection
python3 -c "from gpiozero import Button; b = Button(17); print('Press the button...'); b.wait_for_press(); print('Button pressed! GPIO working.')"
```

Press your tactile button — you should see "Button pressed!" in the terminal.

**If the button test fails:**
```bash
# Check GPIO 17 configuration
pinctrl get 17

# Should show: 17: ip pn | hi // GPIO17 = input, high (correct when button not pressed)
# If it shows 'lo' permanently, the wires are incorrectly placed — see Troubleshooting
```

## Assembled Setup Summary

```
Power Supply (27W USB-C)
         │
         ▼
    ┌────────────────────────────────┐
    │   Raspberry Pi 5 (in case)     │
    │   + Active Cooler              │
    └────────────────────────────────┘
         │                    │
         │ CAM0               │ GPIO Header
         │                    │
         ▼                    ▼
    ┌─────────────┐      ┌──────────────┐
    │ Camera      │      │  Breadboard  │
    │ Module 3    │      │              │
    │ Wide        │      │  [Button]    │
    │ (ribbon     │      │   │      │   │
    │  cable)     │      │  GND   GPIO17│
    └─────────────┘      └──────────────┘
                         Pin 9   Pin 11
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| **Camera not detected** | Check ribbon cable is fully inserted and locked. Verify contacts face the PCB board, blue tab faces out. Try reseating the cable. Run `rpicam-hello --list-cameras` — should show `imx708` |
| **No display on boot** | Use **HDMI0** port (closest to USB-C power). Pi 5 uses **micro-HDMI** — a standard HDMI cable will not fit. Try a different cable or adapter. Ensure microSD is properly flashed |
| **Button not responding** | Verify jumper wires on correct Pi pins (9=GND, 11=GPIO17). Wires must go into the **main grid** holes next to the button — not the power rail strips at the board edges. One wire above the center gap, one below. Run `pinctrl get 17` — should show `hi` when not pressed |
| **`pinctrl get 17` shows `lo` permanently** | One or both wires are in the wrong position. Both wires are likely on the same side of the center gap (same internal node). Move one wire to the opposite half of the breadboard |
| **Pi won't boot** | Ensure microSD is fully inserted (push until click). Reflash microSD card. Try a different power supply (needs 5V 3A minimum) |
| **Fan not spinning** | Check fan cable is connected to FAN header. Fan may not spin until CPU heats up — run `stress` to test |
| **`rpicam-*` command not found** | Run `sudo apt update && sudo apt install -y libcamera-apps`. On newer Pi OS, commands are `rpicam-hello` / `rpicam-still` (not `libcamera-*`) |
| **`gpiozero` not found** | Run `sudo apt install -y python3-gpiozero` |

## Testing Checklist

Before moving to Phase 3, verify:

- [x] Pi boots to desktop successfully
- [x] Camera detected (`rpicam-hello --list-cameras` shows imx708)
- [x] Test photo captures without errors
- [x] Button press detected by Python script
- [x] Active cooler fan is spinning (or spins under load)
- [x] SSH works (if configured) — test with `ssh username@kmeraglitch.local`
- [x] Wi-Fi connected (if configured)

## Next Steps

→ [Phase 3: Software Foundation](PHASE_3.md) — Camera capture script + GPIO button handling

## Reference Links

- [Pi Camera official guide](https://www.raspberrypi.com/documentation/accessories/camera.html)
- [GPIO pinout reference](https://pinout.xyz/)
- [picamera2 documentation](https://pip-assets.raspberrypi.com/categories/652-raspberry-pi-camera-module-2/documents/RP-008156-DS-2-picamera2-manual.pdf)
- [gpiozero documentation](https://gpiozero.readthedocs.io/)
