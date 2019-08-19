# frozen_string_literal: true

# Creates a city with refer point in [0, 0], full of trees, rocks and houses!

class LocalMap
  def initialize(map_to_load_x, map_to_load_y)
    @x = @y = 0
    @nature = Nature.new
    @village = Village.new
    @people = People.new
    @pokemons = WildPokemons.new

    #@nature.spawn_trees_on_screen_edge

#    @nature.new_tree(x of tree, y of tree)
#    @nature.new_stone(x of stone, y of stone)
#    @village.new_house(x of house, y of house)
#    @people.new_friendPerson(npc x, npc y, :dir, image of npc, speech region, text speech of npc)
#     EXAMPLE: @people.new_friendPerson(800, 900, :down, 0, 1)

    @path_to_map = "media/maps/" + map_to_load_x.to_s + map_to_load_y.to_s + ".txt"

    File.readlines(@path_to_map).each do |phrase|
      phrase.split(" ").each_cons(6) do |num|
        if num[0] == "T"
          @nature.new_tree(num[1].to_i, num[2].to_i)
        elsif num[0] == "S"
          @nature.new_stone(num[1].to_i, num[2].to_i)
        elsif num[0] == "H"
          @village.new_house(num[1].to_i, num[2].to_i)
        elsif num[0] == "L"
          @nature.new_lake(num[1].to_i, num[2].to_i, num[3].to_i, num[4].to_i)
        elsif num[0] == "P"
          @pokemons.new_pokemon(num[1].to_i, num[2].to_i, num[3].to_i)
        elsif num[0] == "F"
          @people.new_friendPerson(num[1].to_i, num[2].to_i, num[3].to_sym, num[4].to_i, map_to_load_x, map_to_load_y, num[5].to_i)
        end
      end
    end

    # @people.new_friendPerson(800, 900, :down, 0, 1)
    # @nature.new_tree(600, 400)
    # @nature.new_stone(500, 800)
    # @village.new_house(1100, 400)
    # @pokemons.new_pokemon(300, 300, 1)

  end

  def update(x, y, dir)
    @people.update(x, y, dir)
    @pokemons.update
  end

  def draw
    @village.draw
    @nature.draw
    @people.draw
    @pokemons.draw
  end

  # Checks if player hits some obeject near him
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 solid object, false otherwise
  def colliding?(x, y, dir)
    @village.colliding_to_houses?(x, y, dir) ||
      @nature.colliding_to_trees?(x, y, dir) ||
      @nature.colliding_to_stones?(x, y, dir) ||
      @nature.colliding_to_lakes?(x, y, dir) ||
      @people.colliding_to_people?(x, y, dir) ||
      @pokemons.colliding_to_pokemons?(x, y, dir)
  end

  def clear_all
    @nature.clear
    @village.clear
    @people.clear
    @pokemons.clear
  end

end
