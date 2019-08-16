TREE_WIDTH = 46 * 5
TREE_HEIGHT = 51 * 5

class Tree
  def initialize(x, y)
    @x = x
    @y = y

    @factor_x = 5.0
    @factor_y = 5.0

    @image = Gosu::Image.new("media/tree.bmp")

  end

  def draw
    @image.draw(@x, @y, ZOrder::OBSTACLES, @factor_x, @factor_y)
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
