# frozen_string_literal: true

class Stone
  def initialize(x, y)
    @x = x
    @y = y

    @image = Gosu::Image.new('media/nature/stone1.bmp')
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
      x <= @x + STONE_WIDTH - AVATAR_A && x >= @x - AVATAR_B &&
        y <= @y + STONE_HEIGHT - AVATAR_D && y >= @y
    elsif dir == :left
      x <= @x + STONE_WIDTH && x >= @x &&
        y <= @y + STONE_HEIGHT - AVATAR_F && y >= @y - AVATAR_E
    elsif dir == :down
      x <= @x + STONE_WIDTH - AVATAR_A && x >= @x - AVATAR_B &&
        y <= @y + STONE_HEIGHT - AVATAR_F && y >= @y - AVATAR_F
    elsif dir == :right
      x <= @x + STONE_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + STONE_HEIGHT - AVATAR_F && y >= @y - AVATAR_E
    end
  end
end
