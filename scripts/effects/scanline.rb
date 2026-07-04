require "rmagick"
  require_relative "../config"

  module Effects
    module Scanline
      def self.apply(image, rng)
        out = image.copy
        rng.rand(Config::SCANLINE_COUNT).times do
          h = rng.rand(Config::SCANLINE_HEIGHT)
          y = rng.rand(0..(out.rows - h))
          slice = out.crop(0, y, out.columns, h, true)
          rolled = slice.roll(rng.rand(-Config::SCANLINE_MAX_SHIFT..Config::SCANLINE_MAX_SHIFT), 0)
          out.composite!(rolled, 0, y, Magick::CopyCompositeOp)
          slice.destroy!
          rolled.destroy!
        end
        out
      end
    end
  end

  #  Crop a full-width slice, roll it sideways (wrap-around = clean digital tear), paste it back. The true in crop resets the slice's page offset so the composite lands at the coordinates given