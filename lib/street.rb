class Street
  def initialize(x, y)
    @image = Gosu::Image.new("media/street_down_up.bmp")
    @factor_x = 5.0
    @factor_y = 5.0

  # HOUSE STREET RIGHT UNDER DOOR
  #  @x = 0 + 50
  #  @y = 0 + HOUSE_HEIGHT - 20

    @x = x
    @y = y

  end

  def draw
    @image.draw(@x, @y, ZOrder::STREET, @factor_x, @factor_y)
  end
end
