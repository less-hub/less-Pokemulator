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
      x <= @x + TREE_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + TREE_HEIGHT - AVATAR_D && y >= @y
    elsif dir == :left
      x <= @x + TREE_WIDTH && x >= @x &&
        y <= @y + TREE_HEIGHT - AVATAR_E && y >= @y - AVATAR_D
    elsif dir == :down
      x <= @x + TREE_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + TREE_HEIGHT - AVATAR_E && y >= @y - AVATAR_E
    elsif dir == :right
      x <= @x + TREE_WIDTH - AVATAR_A && x >= @x - AVATAR_D &&
        y <= @y + TREE_HEIGHT - AVATAR_E && y >= @y - AVATAR_D
    end
  end
end
