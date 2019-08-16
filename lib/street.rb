class Street
  def initialize(x, y)
    @image = Gosu::Image.new("media/street_down_up.bmp")
    @factor_x = 5.0
    @factor_y = 5.0

    @x = x
    @y = y

  end

  def draw
    @image.draw(@x, @y, ZOrder::STREET, @factor_x, @factor_y)
  end
end
