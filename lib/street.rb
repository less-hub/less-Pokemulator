class Street
  def initialize
    @image = Gosu::Image.new("media/street1.png")
    @x = 1920/2
    @y = 1080/2
  end

  def draw
    @image.draw(@x, @y, ZOrder::HOUSE)
  end
end
