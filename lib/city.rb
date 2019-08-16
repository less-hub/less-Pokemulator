# frozen_string_literal: true

# Creates a city with refer point in [0, 0], full of trees, rocks and houses!

class City
  def initialize
    @x = @y = 0
    @nature = Nature.new
    @village = Village.new

    @nature.spawn_trees_on_screen_edge

    @fnpc = Friendlynpc.new(1920 / 2 - 200, 1080 / 2 + 500, :down)
  end

  def draw
    @village.draw
    @nature.draw
    @fnpc.draw
  end

  # Checks if player hits some obeject near him
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 solid object, false otherwise
  def colliding?(x, y, dir)
    @village.colliding_to_houses?(x, y, dir) ||
      @nature.colliding_to_trees?(x, y, dir) ||
      @nature.colliding_to_stones?(x, y, dir) ||
      @fnpc.colliding_to_fnpc?(x, y, dir)
  end
end
