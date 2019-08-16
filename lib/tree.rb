class Tree
  def initialize(x, y)
    @x = x
    @y = y

    @factor_x = 5.0
    @factor_y = 5.0

    @image = Gosu::Image.new("media/tree.bmp")

  end

  def draw
    @image.draw(@x, @y, ZOrder::OBSTACLES, @factor_x, @factor_y)
  end
end
