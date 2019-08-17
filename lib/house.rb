# frozen_string_literal: true

# An house and a pieace of street leading to door will spawn at given position.

class House
  attr_accessor :x, :y

  def initialize(x, y)
    @image = Gosu::Image.new('media/houses/1.bmp')

    @x = x
    @y = y

    @street = Street.new(@x + 30, @y + HOUSE_HEIGHT - 20)
  end

  def draw
    @image.draw(@x, @y, ZOrder::HOUSE, IMAGE_FACTOR_X, IMAGE_FACTOR_Y)
    @street.draw
  end

  # Moves an house to a different location
  # @param: where to move house on x-axis, where to move house on y-axis
  # @return: NIL
  def warp(x, y)
    @x = x
    @y = y
  end

  # Checks if player collides to THIS house
  # @param: player x position, player y position, player direction
  # @return: true if player hits the house, false otherwise
  def collide?(x, y, dir)
    # UNDERSTAND THESE COSTANTS: 10, 15, 35, 80, 90, 100
    if dir == :up
      x <= @x + HOUSE_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + HOUSE_HEIGHT - AVATAR_D && y >= @y
    elsif dir == :left
      x <= @x + HOUSE_WIDTH && x >= @x &&
        y <= @y + HOUSE_HEIGHT - AVATAR_E && y >= @y - AVATAR_D
    elsif dir == :down
      x <= @x + HOUSE_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + HOUSE_HEIGHT - AVATAR_E && y >= @y - AVATAR_E
    elsif dir == :right
      x <= @x + HOUSE_WIDTH - AVATAR_A && x >= @x - AVATAR_D &&
        y <= @y + HOUSE_HEIGHT - AVATAR_E && y >= @y - AVATAR_D
    end
  end
end
