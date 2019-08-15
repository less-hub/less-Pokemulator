HOUSE_WIDTH = 69 * 5
HOUSE_HEIGHT = 72 * 5

class House
  def initialize
    @x = @y = 0

    @factor_x = 5.0
    @factor_y = 5.0

    @image = Gosu::Image.new("media/house1.bmp")

  end

  def draw
    @image.draw(@x, @y, ZOrder::HOUSE, @factor_x, @factor_y)
  end

  def warp(x, y)
    @x = x
    @y = y
  end
end
