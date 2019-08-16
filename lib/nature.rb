class Nature
  def initialize
    @forest = []

    @forest.push(new_tree(700, 200))
    @forest.push(new_tree(1200, 500))
  end

  def new_tree(x, y)
    Tree.new(x, y)
  end

  def draw
    @forest.each(&:draw)
  end

  def colliding_to_trees?(x, y, dir)
    @forest.detect { |tree| tree.collide?(x, y, dir) }
  end

end
