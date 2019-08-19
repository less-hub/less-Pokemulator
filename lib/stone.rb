# frozen_string_literal: true

class Stone < Obstacles
  def initialize(x, y)
    super

    @height = 170
    @width = 165

    @image = Gosu::Image.new("media/nature/stone1.bmp")
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
