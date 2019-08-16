# A forest spawns with refer point in [0, 0]
# You can create a new tree by givinig TREE coord to new_tree, and then
# insert in @forest. Example:
#   @forest.push(new_tree(0, 0)) //Spawns a new tree in 0,0
#
# NOTE: Spawn trees on village constructor!

class Nature
  def initialize
    @forest = []

    @forest.push(new_tree(700, 200))
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

end
