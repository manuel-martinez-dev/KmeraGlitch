 require "rmagick"
  require_relative "../config"

  module Effects
    module Ascii
      def self.apply(image, rng)
        cols = Config::ASCII_COLUMNS
        rows = (image.rows.to_f / image.columns * cols / Config::ASCII_CHAR_ASPECT).round
        small = image.resize(cols, rows)

        out_w = image.columns * Config::ASCII_SCALE
        out_h = image.rows * Config::ASCII_SCALE
        cell_w = out_w.to_f / cols
        cell_h = out_h.to_f / rows

        dark_bg = Config::ASCII_STYLE != :dark_on_light
        canvas = Magick::Image.new(out_w, out_h) do |opt|
          opt.background_color = dark_bg ? "black" : "white"
        end

        draw = Magick::Draw.new
        draw.font = Config::ASCII_FONT
        draw.pointsize = (cell_w * 1.6).round  # tuned for DejaVu Mono; adjust per font
        draw.fill(dark_bg ? "white" : "black")

        ramp = Config::ASCII_RAMP
        rows.times do |r|
          base_y = (r * cell_h + cell_h * 0.8).round  # text y = baseline
          cols.times do |c|
            px = small.pixel_color(c, r)
            lum = (0.299 * px.red + 0.587 * px.green + 0.114 * px.blue) / Magick::QuantumRange
            idx = ((dark_bg ? lum : 1 - lum) * (ramp.length - 1)).round
            ch = ramp[idx]
            next if ch == " "
            draw.fill(px.to_color(Magick::AllCompliance, false, 8, true)) if Config::ASCII_STYLE == :color
            draw.text((c * cell_w).round, base_y, ch)
          end
        end
        draw.draw(canvas)
        small.destroy!
        canvas
      end
    end
  end

  