# frozen_string_literal: true

class Lake
  def initialize(x, y, lake_scale_x, lake_scale_y)
    @x = x
    @y = y

    @scale_x = lake_scale_x
    @scale_y = lake_scale_y

    @LAKE_WIDTH = 100 * @scale_x
    @LAKE_HEIGHT = 100 * @scale_y

    @lake_image = Gosu::Image.new('media/nature/lake.bmp')
  end

  def draw
    @lake_image.draw(@x, @y, ZOrder::OBSTACLES, @scale_x, @scale_y)
  end

  # Moves a lake to a different location
  # @param: where to move lake on x-axis, where to move lake on y-axis
  # @return: NIL
  def warp(x, y)
    @x = x
    @y = y
  end

  # Checks if player collides to THIS lake
  # @param: player x position, player y position, player direction
  # @return: true if player hits the lake, false otherwise
  def collide?(x, y, dir)
    # UNDERSTAND THESE COSTANTS: 10, 15, 35, 80, 90, 100
    if dir == :up
      x <= @x + @LAKE_WIDTH - 5 && x >= @x - 60 &&
        y <= @y + @LAKE_HEIGHT - 80 && y >= @y
    elsif dir == :left
      x <= @x + @LAKE_WIDTH && x >= @x &&
        y <= @y + @LAKE_HEIGHT - 90 && y >= @y - 80
    elsif dir == :down
      x <= @x + @LAKE_WIDTH - 5 && x >= @x - 60 &&
        y <= @y + @LAKE_HEIGHT - 90 && y >= @y - 90
    elsif dir == :right
      x <= @x + @LAKE_WIDTH - 5 && x >= @x - 80 &&
        y <= @y + @LAKE_HEIGHT - 90 && y >= @y - 80
    end
  end
end
