# frozen_string_literal: true

class Tree < Obstacles
  def initialize(x, y)
    super

    @height = 255
    @width = 230

    @image = Gosu::Image.new("media/nature/tree.bmp")
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
