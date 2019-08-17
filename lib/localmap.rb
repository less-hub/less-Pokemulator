# frozen_string_literal: true

# Creates a city with refer point in [0, 0], full of trees, rocks and houses!

class LocalMap
  def initialize
    @x = @y = 0
    @nature = Nature.new
    @village = Village.new
    @people = People.new

    @nature.spawn_trees_on_screen_edge

#    @nature.new_tree(x of tree, y of tree)
#    @nature.new_stone(x of stone, y of stone)

#    @village.new_house(x of house, y of house)

#    @people.new_friendPerson(npc x, npc y, :dir, image of npc, text speech of npc)
#     EXAMPLE: @people.new_friendPerson(800, 900, :down, 0, 1)

  end

  def update(x, y, dir)
    @people.update(x, y, dir)
  end

  def draw
    @village.draw
    @nature.draw
    @people.draw
  end

  # Checks if player hits some obeject near him
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 solid object, false otherwise
  def colliding?(x, y, dir)
    @village.colliding_to_houses?(x, y, dir) ||
      @nature.colliding_to_trees?(x, y, dir) ||
      @nature.colliding_to_stones?(x, y, dir) ||
      @people.colliding_to_people?(x, y, dir)
  end

end
