# A village spawns with refer point in [0, 0]
# You can create a new house by givinig HOUSE coord to new_house, and then
# insert in @village. Example:
#   @village.push(new_house(0, 0)) //Spawns a new house in 0,0
#
# NOTE: Spawn houses on village constructor!

class Village
  def initialize
    @village = []
    @village.push(new_house(400, 400))
  end

  def draw
    @village.each(&:draw)
  end

  # Builds a new house in given position
  # @param: x-axis of house, y-axis of house
  # @return: House at given position
  def new_house(x, y)
    House.new(x, y)
  end

  # Checks if player hits the houses
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 house, false otherwise
  def colliding_to_houses?(x, y, dir)
    @village.detect { |house| house.collide?(x, y, dir) }
  end

end
