# frozen_string_literal: true

# Creates a city with refer point in [0, 0], full of trees, rocks and houses!

class LocalMap
  attr_accessor :combat_status, :fighting_pokemon

  def initialize(map_to_load_x, map_to_load_y)
    @mapobjects = MapObjects.new
    @fighting_pokemon = Array.new

    @combat_status = false

    @path_to_map = "media/maps/" + map_to_load_x.to_s + map_to_load_y.to_s + ".txt"

    File.readlines(@path_to_map).each do |phrase|
      phrase.split(" ").each_cons(7) do |num|
        if num[0] == "T"
          @mapobjects.new_tree(num[1].to_i, num[2].to_i)
        elsif num[0] == "S"
          @mapobjects.new_stone(num[1].to_i, num[2].to_i)
        elsif num[0] == "H"
          @mapobjects.new_house(num[1].to_i, num[2].to_i)
        elsif num[0] == "L"
          @mapobjects.new_lake(num[1].to_i, num[2].to_i, num[3].to_i, num[4].to_i)
        elsif num[0] == "P"
          @mapobjects.new_pokemon(num[1].to_i, num[2].to_i, num[3].to_i)
        elsif num[0] == "F"
          @mapobjects.new_friendPerson(num[1].to_i, num[2].to_i, num[3].to_sym, num[4].to_i, map_to_load_x, map_to_load_y, num[5], num[6].to_i)
        end
      end
    end
  end

  def update(x, y, dir)
    @mapobjects.update(x, y, dir)
  end

  def draw
    @mapobjects.draw
  end

  # Checks if player hits some obeject near him
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 solid object, false otherwise
  def colliding?(x, y, dir)
    @mapobjects.collide?(x, y, dir)
  end

  def clear_all
    @mapobjects.clear
  end

  def met_wild_pokemon?(x, y, dir)
    if @mapobjects.colliding_to_pokemons?(x, y, dir)
      @fighting_pokemon.push(@mapobjects.colliding_to_pokemons?(x, y, dir))
      @combat_status = true
    end

    @mapobjects.colliding_to_pokemons?(x, y, dir)
  end

  def wild_poke_defeated?
    @mapobjects.pokemon_dead?
  end

  def drowned?(x, y, dir)
    @mapobjects.colliding_to_lakes?(x, y, dir)
  end

end
