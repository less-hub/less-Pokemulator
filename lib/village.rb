# frozen_string_literal: true

# A village spawns with refer point in [0, 0]
# You can create a new house by givinig HOUSE coord to new_house, and then
# insert in @village. Example:
#   @village.push(new_house(0, 0)) //Spawns a new house in 0,0
#
# NOTE: Spawn houses on village constructor!

class Village
  def initialize
    @x = @y = 0
    @village = []
    @forest = []

    @village.push(new_house(200, 200))
    @forest.push(new_tree(700, 200))
  end

  def draw
    @village.each(&:draw)
    @forest.each(&:draw)
  end

  # Builds a new house in given position
  # @param: x-axis of house, y-axis of house
  # @return: House at given position
  def new_house(x, y)
    House.new(x, y)
  end

  def new_tree(x, y)
    Tree.new(x, y)
  end

  # Checks if player hits the house
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 house, false otherwise
  def colliding_to_houses?(x, y, dir)
    @village.detect { |house| house.collide?(x, y, dir) } ||
      @forest.detect { |tree| tree.collide?(x, y, dir) }
  end
end
