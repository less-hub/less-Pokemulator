# frozen_string_literal: true

# Creates a city with refer point in [0, 0], full of trees, rocks and houses!

class City
  def initialize
    @x = @y = 0
    @nature = Nature.new
    @village = Village.new
    @stone = Stone.new(900, 400)

    @nature.spawn_trees_on_screen_edge
  end

  def draw
    @village.draw
    @nature.draw
    @stone.draw
  end

  # Checks if player hits some obeject near him
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 solid object, false otherwise
  def colliding?(x, y, dir)
    @village.colliding_to_houses?(x, y, dir) ||
      @nature.colliding_to_trees?(x, y, dir) ||
      @stone.collide?(x, y, dir)
  end
end
