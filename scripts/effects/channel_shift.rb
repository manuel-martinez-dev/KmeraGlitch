 require "rmagick"
  require_relative "../config"

  module Effects
    module ChannelShift
      OPS = [
        Magick::CopyRedCompositeOp,
        Magick::CopyGreenCompositeOp,
        Magick::CopyBlueCompositeOp,
      ]

      def self.apply(image, rng)
        max = Config::CHANNEL_SHIFT_MAX
        out = image.copy
        OPS.each do |op|
          shifted = image.roll(rng.rand(-max..max), rng.rand(-max..max))
          out.composite!(shifted, 0, 0, op)
          shifted.destroy!
        end
        out
      end
    end
  end

  #  roll shifts with wrap-around (no black edges); each Copy*CompositeOp copies only that one channel from the rolled copy, so the three channels drift apart independently. destroy! frees each ~35MB full-res buffer immediately