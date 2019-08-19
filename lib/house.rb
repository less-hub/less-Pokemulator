# frozen_string_literal: true

class House < Obstacles
  def initialize(x, y)
    super


    @width = 305
    @height = 300

    @street = Street.new(@x + 30, @y + @height - 20)
    
    @image = Gosu::Image.new("media/houses/1.bmp")
  end

  def draw
    @image.draw(@x, @y, ZOrder::OBSTACLES, @scale_x, @scale_y)
    @street.draw
  end

  def warp(x, y)
    super
  end

  def collide?(x, y, dir)
    super
  end
end
