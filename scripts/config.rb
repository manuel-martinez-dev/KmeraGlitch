 module Config
    # Storage
    RAW_DIR = "/photos/raw"
    PROCESSED_DIR = "/photos/processed"

    # Hot pixel [x, y] in full-res coords; nil = skip correction
    HOT_PIXEL = nil

    # Channel shift: each RGB channel gets a random offset in -MAX..MAX px
    CHANNEL_SHIFT_MAX = 24

    # Scanline displacement
    SCANLINE_COUNT = 11..32       # how many slices get displaced
    SCANLINE_HEIGHT = 9..125      # slice height in px
    SCANLINE_MAX_SHIFT = 433      # max sideways shift in px (wraps around)

    # ASCII — comics preset (fine grid, print-ready at panel size)
    ASCII_STYLE = :dark_on_light  # :dark_on_light | :light_on_dark | :color
    ASCII_RAMP = " .:-=+*#%@"     # light -> dark (no quote chars)
    ASCII_COLUMNS = 160           # characters per row
    ASCII_FONT = "DejaVu-Sans-Mono"  # system font name, or a .ttf path
    ASCII_CHAR_ASPECT = 2.0       # char height/width ratio
    ASCII_SCALE = 1               # canvas multiplier: 1 = comics, 2-3 = large-format

    # ASCII — canvas preset (swap in when a shot is headed to the plotter):
    #   ASCII_COLUMNS = 60
    #   ASCII_FONT = "/home/manuma/fonts/3d-isometric.ttf"
    #   ASCII_SCALE = 3
  end