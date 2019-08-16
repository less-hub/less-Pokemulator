HOUSE_WIDTH = 69 * 5
HOUSE_HEIGHT = 72 * 5

class House
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y

    @factor_x = 5.0
    @factor_y = 5.0

    @image = Gosu::Image.new("media/house1.bmp")

    @street = Street.new(@x + 50, @y + HOUSE_HEIGHT - 20)


  end

  def draw
    @image.draw(@x, @y, ZOrder::HOUSE, @factor_x, @factor_y)
    @street.draw
  end

  def warp(x, y)
    @x = x
    @y = y
  end

  def collide?(x, y, dir)
    # UNDERSTAND THESE COSTANTS: 10, 15, 35, 80, 90, 100
    if dir == :up
      x <= @x + HOUSE_WIDTH - 15 && x >= @x - 35 && y <= @y + HOUSE_HEIGHT - 80 && y >= @y
    elsif dir == :left
      x <= @x + HOUSE_WIDTH && x>= @x && y <= @y + HOUSE_HEIGHT - 100 && y >= @y - 90
    elsif dir == :down
      x <= @x + HOUSE_WIDTH - 15 && x >= @x - 35 && y <= @y + HOUSE_HEIGHT - 100 && y >= @y - 100
    elsif dir == :right
      x <= @x + HOUSE_WIDTH - 15 && x >= @x - 45 && y <= @y + HOUSE_HEIGHT - 100 && y >= @y - 90
    end
  end
end
