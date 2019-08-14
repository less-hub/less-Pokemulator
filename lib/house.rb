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
end
