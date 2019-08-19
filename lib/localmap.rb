# frozen_string_literal: true

# Creates a city with refer point in [0, 0], full of trees, rocks and houses!

class LocalMap
  def initialize(map_to_load_x, map_to_load_y)
    @x = @y = 0
    @mapobjects = MapObjects.new

    @path_to_map = "media/maps/" + map_to_load_x.to_s + map_to_load_y.to_s + ".txt"

    File.readlines(@path_to_map).each do |phrase|
      phrase.split(" ").each_cons(6) do |num|
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
          @mapobjects.new_friendPerson(num[1].to_i, num[2].to_i, num[3].to_sym, num[4].to_i, map_to_load_x, map_to_load_y, num[5].to_i)
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

  def drowned?(x, y, dir)
    @mapobjects.colliding_to_lakes?(x, y, dir)
  end

end
