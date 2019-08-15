HOUSE_WIDTH = 69 * 3
HOUSE_HEIGHT = 72 * 3

class House
  def initialize
    @x = @y = 0

    @factor_x = 3.0
    @factor_y = 3.0

    @image = Gosu::Image.new("media/house1.bmp")

  end

  def draw
    @image.draw(@x, @y, ZOrder::HOUSE, @factor_x, @factor_y)
  end

  def warp(x, y)
    @x = x
    @y = y
  end

  def collide?(x, y, dir)
    # UNDERSTAND THESE COSTANTS: 10, 15, 35, 80, 90, 100
    if dir == :up
      x <= @x + HOUSE_WIDTH - 9 && x >= @x - 21 && y <= @y + HOUSE_HEIGHT - 48 && y >= @y
    elsif dir == :left
      x <= @x + HOUSE_WIDTH && x>= @x && y <= @y + HOUSE_HEIGHT - 60 && y >= @y - 54
    elsif dir == :down
      x <= @x + HOUSE_WIDTH - 9 && x >= @x - 21 && y <= @y + HOUSE_HEIGHT - 60 && y >= @y - 60
    elsif dir == :right
      x <= @x + HOUSE_WIDTH - 9 && x >= @x - 27 && y <= @y + HOUSE_HEIGHT - 60 && y >= @y - 54
    end
  end
end
