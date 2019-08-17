# frozen_string_literal: true

class Tree
  def initialize(x, y)
    @x = x
    @y = y

    @image = Gosu::Image.new('media/nature/tree.bmp')
  end

  def draw
    @image.draw(@x, @y, ZOrder::OBSTACLES, IMAGE_FACTOR_X, IMAGE_FACTOR_Y)
  end

  # Moves a tree to a different location
  # @param: where to move tree on x-axis, where to move tree on y-axis
  # @return: NIL
  def warp(x, y)
    @x = x
    @y = y
  end

  # Checks if player collides to THIS tree
  # @param: player x position, player y position, player direction
  # @return: true if player hits the tree, false otherwise
  def collide?(x, y, dir)
    # UNDERSTAND THESE COSTANTS: 10, 15, 35, 80, 90, 100
    if dir == :up
      x <= @x + TREE_WIDTH - 15 && x >= @x - 35 &&
        y <= @y + TREE_HEIGHT - 80 && y >= @y
    elsif dir == :left
      x <= @x + TREE_WIDTH && x >= @x &&
        y <= @y + TREE_HEIGHT - 100 && y >= @y - 90
    elsif dir == :down
      x <= @x + TREE_WIDTH - 15 && x >= @x - 35 &&
        y <= @y + TREE_HEIGHT - 100 && y >= @y - 100
    elsif dir == :right
      x <= @x + TREE_WIDTH - 15 && x >= @x - 45 &&
        y <= @y + TREE_HEIGHT - 100 && y >= @y - 90
    end
  end
end
