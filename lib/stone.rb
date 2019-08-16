class Stone
  def initialize(x, y)
    @x = x
    @y = y

    @image = Gosu::Image.new("media/stone1.bmp")

  end

  def draw
    @image.draw(@x, @y, ZOrder::OBSTACLES, IMAGE_FACTOR_X, IMAGE_FACTOR_Y)
  end

  # Moves a stone to a different location
  # @param: where to move stone on x-axis, where to move stone on y-axis
  # @return: NIL
  def warp(x, y)
    @x = x
    @y = y
  end

  # Checks if player collides to THIS stone
  # @param: player x position, player y position, player direction
  # @return: true if player hits the stone, false otherwise
  def collide?(x, y, dir)
    # UNDERSTAND THESE COSTANTS: 10, 15, 35, 80, 90, 100
    if dir == :up
      x <= @x + STONE_WIDTH - 15 && x >= @x - 35 &&
        y <= @y + STONE_HEIGHT - 80 && y >= @y
    elsif dir == :left
      x <= @x + STONE_WIDTH && x >= @x &&
        y <= @y + STONE_HEIGHT - 100 && y >= @y - 90
    elsif dir == :down
      x <= @x + STONE_WIDTH - 15 && x >= @x - 35 &&
        y <= @y + STONE_HEIGHT - 100 && y >= @y - 100
    elsif dir == :right
      x <= @x + STONE_WIDTH - 15 && x >= @x - 45 &&
        y <= @y + STONE_HEIGHT - 100 && y >= @y - 90
    end
  end
end
