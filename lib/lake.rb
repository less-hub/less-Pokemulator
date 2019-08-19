# frozen_string_literal: true

class Lake < Obstacles
  def initialize(x, y, lake_scale_x, lake_scale_y)
    super(x, y)

    @scale_x = lake_scale_x
    @scale_y = lake_scale_y

    @width = 100 * @scale_x
    @height = 100 * @scale_y

    @image = Gosu::Image.new('media/nature/lake.bmp')
  end

  def draw
    super
  end

  def warp(x, y)
    super
  end

  # 44 = player_width / 2
  # 104 = player_height
  def collide?(x, y, dir)
    if dir == :up
      x <= @x + @width - 44 && x >= @x - 44 &&
        y <= @y + @height - 104 && y >= @y - 104
    elsif dir == :left
      x <= @x + @width - 44 && x >= @x - 44 &&
        y <= @y + @height - 104 && y >= @y - 104
    elsif dir == :down
      x <= @x + @width - 44 && x >= @x - 44 &&
        y <= @y + @height - 104 && y >= @y - 104
    elsif dir == :right
      x <= @x + @width - 44 && x >= @x - 44 &&
        y <= @y + @height - 104 && y >= @y - 104
    end
  end
end
