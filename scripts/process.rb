 #!/usr/bin/env ruby
  require "fileutils"
  require "rmagick"
  require_relative "config"
  require_relative "effects/channel_shift"
  require_relative "effects/scanline"
  require_relative "effects/ascii"

  EFFECTS = %w[channelshift scanline glitch ascii].freeze

  input, effect, seed_arg = ARGV
  unless input && EFFECTS.include?(effect)
    abort "Usage: ruby process.rb <input.png> <#{EFFECTS.join('|')}> [seed]"
  end
  abort "No such file: #{input}" unless File.file?(input)

  seed = seed_arg ? Integer(seed_arg) : rand(1_000_000)
  rng = Random.new(seed)
  puts "Effect: #{effect}  Seed: #{seed}"

  image = Magick::Image.read(input).first

  # Hot pixel: replace with average of 8 neighbours
  if Config::HOT_PIXEL
    x, y = Config::HOT_PIXEL
    neighbours = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
                 .map { |dx, dy| image.pixel_color(x + dx, y + dy) }
    image.pixel_color(x, y, Magick::Pixel.new(
      neighbours.sum(&:red) / 8,
      neighbours.sum(&:green) / 8,
      neighbours.sum(&:blue) / 8
    ))
  end

  result =
    case effect
    when "channelshift" then Effects::ChannelShift.apply(image, rng)
    when "scanline"     then Effects::Scanline.apply(image, rng)
    when "glitch"       then Effects::Scanline.apply(Effects::ChannelShift.apply(image, rng), rng)
    when "ascii"        then Effects::Ascii.apply(image, rng)
    end

  FileUtils.mkdir_p(Config::PROCESSED_DIR)
  out_path = File.join(Config::PROCESSED_DIR, "#{File.basename(input, '.*')}_#{effect}.png")
  result.write(out_path)
  puts "Saved: #{out_path}"