# frozen_string_literal: true

# Spawns a street at given position.
# NOTE: Street image PX: 34 x 34
#       Street PX factor: 5.0

class Street
  def initialize(x, y)
    @image = Gosu::Image.new('media/street_down_up.bmp')

    @x = x
    @y = y
  end

  def draw
    @image.draw(@x, @y, ZOrder::STREET, 5.0, 5.0)
  end
end
