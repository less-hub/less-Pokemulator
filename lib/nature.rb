# A forest spawns with refer point in [0, 0]
# You can create a new tree by givinig TREE coord to new_tree, and then
# insert in @forest. Example:
#   @forest.push(new_tree(0, 0)) //Spawns a new tree in 0,0
#
# NOTE: Spawn trees on village constructor!

class Nature
  def initialize
    @x = 0
    @y = 0
    @forest = []

    @forest.push(new_tree(1200, 500))
  end

  # Builds a new tree in given position
  # @param: x-axis of tree, y-axis of tree
  # @return: Tree at given position
  def new_tree(x, y)
    Tree.new(x, y)
  end

  def draw
    @forest.each(&:draw)
  end

  # Checks if player hits the trees
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 tree, false otherwise
  def colliding_to_trees?(x, y, dir)
    @forest.detect { |tree| tree.collide?(x, y, dir) }
  end

  # Spawns an horizontal line of trees
  # @param: where to spawn trees from, number of trees
  # @return: NIL
  def spawn_trees_line_on_x(x, trees_number)
    trees_number.times { |counter| @forest.push(Tree.new(((@x + x) + counter * TREE_WIDTH), 0)) }
  end

  # Spawns a vertical line of trees
  # @param: where to spawn trees from, number of trees
  # @return: NIL
  def spawn_trees_line_on_y(y, trees_number)
    trees_number.times { |counter| @forest.push(Tree.new(0, (@y + y) + counter * TREE_WIDTH)) }
  end

  def spawn_trees_on_screen_edge
    spawn_trees_line_on_x(0, (2 * WIDTH / TREE_WIDTH) + 1)
    spawn_trees_line_on_y(TREE_HEIGHT, (2 * HEIGHT / TREE_HEIGHT) + 1)
  end

end
