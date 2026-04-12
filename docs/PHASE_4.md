# Phase 4: Creative Tools

> **Status: Pre-planning**

## Overview

This phase builds the Ruby image processing pipeline that transforms raw captures into creative outputs. Two workflows are supported: glitched/ASCII images for comics, and high-resolution outputs for large-format canvas prints with manual painting.

## What This Phase Delivers

- `scripts/process.rb` — main pipeline entry point, accepts input file and effect type
- `scripts/effects/glitch.rb` — pixel glitch effect
- `scripts/effects/ascii.rb` — ASCII art conversion
- `scripts/config.rb` — output settings (paths, formats)
- Hot pixel correction applied to all outputs
- Rotation correction applied to all outputs (until camera mount is resolved), but not *important* for now.

## Output Format

All outputs are PNG. Downscaling or format conversion happens on the computer after transfer, not in the pipeline.

## Prerequisites

- Phase 3 complete (captures working, PNGs saving to `/photos/raw`)
- Ruby installed on Pi
- ImageMagick + RMagick gem installed

## Steps

*(To be written when Phase 4 begins)*

1. Install dependencies (Ruby, ImageMagick, RMagick)
2. Write `config.rb`
3. Write `glitch.rb`
4. Write `ascii.rb`
5. Write `process.rb` pipeline entry point
6. Test on sample captures
7. Transfer outputs to computer for final use

## Known Considerations

- **Hot pixel correction** — single red stuck pixel at fixed coordinates on Camera Module 3. Must be corrected before any effect is applied. Exact coordinates to be determined from a full-res PNG.
- **Rotation correction** — camera currently mounted sideways. Pipeline should auto-rotate until physical mount is resolved. *not important* (once a proper mount is set we can cosnider this)
- **PNG compress_level** — currently default (1) from capture. Can be tuned here if needed.

## Next Steps

→ Phase 5: Integration + Testing

## Reference Links

*(To be added when Phase 4 begins)*
