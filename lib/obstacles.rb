class Obstacles
  # Creates an obstacle at given coords
  # @param: obstacle x-axis, obstacle y-axis
  # @return: Obstacle at given position
  def initialize(x, y)
    @x = x
    @y = y

    @height = @width = 0

    @scale_x = 5.0
    @scale_y = 5.0

  end

  def draw
    @image.draw(@x, @y, ZOrder::OBSTACLES, @scale_x, @scale_y)
  end

  # Moves the obstacle to a different location
  # @param: obstacle new x-axis, obstacle new y-axis
  # @return: //
  def warp(x, y)
    @x = x
    @y = y
  end

  # Checks if player collides to the obstacle
  # @param: player x-axis, player y-axis, player direction
  # @return: True if player collides obstacle, false otherwise
  def collide?(x, y, dir)
    if dir == :up
      x <= @x + @width - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + @height - AVATAR_D && y >= @y
    elsif dir == :left
      x <= @x + @width && x >= @x &&
        y <= @y + @height - AVATAR_E && y >= @y - AVATAR_D
    elsif dir == :down
      x <= @x + @width - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + @height - AVATAR_E && y >= @y - AVATAR_E
    elsif dir == :right
      x <= @x + @width - AVATAR_A && x >= @x - AVATAR_D &&
        y <= @y + @height - AVATAR_E && y >= @y - AVATAR_D
    end
  end
end
