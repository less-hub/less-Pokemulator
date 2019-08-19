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

  def collide?(x, y, dir)
    super
  end
end
