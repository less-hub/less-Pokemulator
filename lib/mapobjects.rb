# frozen_string_literal: true

# A forest spawns with refer point in [0, 0]
# You can create a new tree by givinig TREE coord to new_tree, and then
# insert in @forest. Example:
#   @forest.push(new_tree(0, 0)) //Spawns a new tree in 0,0
#
# NOTE: Spawn trees on village constructor!

class MapObjects
  def initialize
    @x = 0
    @y = 0
    @forest = []
    @hound = []
    @lakes = []
    @village = []
    @people = []
    @wildpokemons = []

  end

  def update(x, y, dir)
    @people.each do |friendPerson|
      friendPerson.update(x, y, dir)
    end

    move_y = 0
    move_x = 0

    move_y += 5 if (Gosu.milliseconds / 1750).even?
    move_y -= 5 if (Gosu.milliseconds / 2000).even?
    move_x += 5 if (Gosu.milliseconds / 2250).even?
    move_x -= 5 if (Gosu.milliseconds / 2500).even?

    @wildpokemons.each { |pok| pok.update(move_x, move_y) }
  end

  def draw
    @forest.each(&:draw)
    @hound.each(&:draw)
    @lakes.each(&:draw)
    @village.each(&:draw)
    @people.each(&:draw)
    @wildpokemons.each(&:draw)
  end

  # Builds a new tree in given position
  # @param: x-axis of tree, y-axis of tree
  # @return: Tree at given position
  def new_tree(x, y)
    @forest.push(Tree.new(x, y))
  end

  # Builds a new stone in given position
  # @param: x-axis of stone, y-axis of stone
  # @return: Stone at given position
  def new_stone(x, y)
    @hound.push(Stone.new(x, y))
  end

  # Builds a new lake in given position
  # @param: x-axis of lake, y-axis of lake
  # @return: Lake at given position
  def new_lake(x, y, sx, sy)
    @lakes.push(Lake.new(x, y, sx, sy))
  end

  # Builds a new house in given position
  # @param: x-axis of house, y-axis of house
  # @return: House at given position
  def new_house(x, y)
    @village.push(House.new(x, y))
  end

  # Builds a new friendly NPC at given position
  # @param: NPC x, NPC y, NPC image, NPC map x, NPC map y, NPC name, text to say
  # @return: NPC at given position
  def new_friendPerson(x, y, dir, npc_kind, map_to_load_x, map_to_load_y, name, text_ind)
    @people.push(FriendPerson.new(x, y, dir, npc_kind, map_to_load_x, map_to_load_y, name, text_ind))
  end

  # Builds a new pokemon in given position
  # @param: x-axis of pokemon, y-axis of pokemon, pokedex number of pokemon
  # @return: Pokemon at given position
  def new_pokemon(x, y, pokedex_number)
    @wildpokemons.push(Pokemon.new(x, y, pokedex_number))
  end

  # Checks if player collides to objects
  # @param: player x, player y, player direction
  # @return: True if player collides, false otherwise
  def collide?(x, y, dir)
    @forest.detect { |tree| tree.collide?(x, y, dir) } ||
    @hound.detect { |stone| stone.collide?(x, y, dir) } ||
    @village.detect { |house| house.collide?(x, y, dir) } ||
    @people.detect { |friendPerson| friendPerson.collide?(x, y, dir) }
  end

  # Checks if player hits the lake
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 lake, false otherwise
  def colliding_to_lakes?(x, y, dir)
    @lakes.detect { |lake| lake.collide?(x, y, dir) }
  end

  # Checks if player hits the pokemon
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 pokemon, false otherwise
  def colliding_to_pokemons?(x, y, dir)
    @wildpokemons.detect { |poke| poke.collide?(x, y, dir) }
  end

  # Spawns an horizontal line of trees
  # @param: trees from x position, number of trees, trees from y position
  # @return: NIL
  def spawn_trees_line_on_x(x, trees_number, y)
    trees_number.times { |counter| @forest.push(Tree.new(((@x + x) + counter * (TREE_WIDTH + 10)), y)) }
  end

  # Spawns a vertical line of trees with an x offset
  # @param: trees from y position, number of trees, trees from x position
  # @return: NIL
  def spawn_trees_line_on_y(y, trees_number, x)
    trees_number.times { |counter| @forest.push(Tree.new(x, (@y + y) + counter * (TREE_WIDTH + 10))) }
  end

  # Spawns trees on the edge of the screen
  # @param: NIL
  # @return: NIL
  def spawn_trees_on_screen_edge
    spawn_trees_line_on_x(0, (2 * WIDTH / TREE_WIDTH) + 1, 0)
    spawn_trees_line_on_y(TREE_HEIGHT, (2 * HEIGHT / TREE_HEIGHT) - 1, 0)
    spawn_trees_line_on_x(0, (2 * WIDTH / TREE_WIDTH) + 1, 2 * HEIGHT - TREE_HEIGHT)
    spawn_trees_line_on_y(TREE_HEIGHT, (2 * HEIGHT / TREE_HEIGHT) - 1, 2 * WIDTH - TREE_WIDTH)
  end

  def pokemon_dead?
    @wildpokemons.reject! { |poke| poke.dead? }
  end

  # Clears all objects on the map
  # @param: NIL
  # @return: Cleared map
  def clear
    @forest.clear
    @hound.clear
    @lakes.clear
    @village.clear
    @people.clear
    @wildpokemons.clear
  end
end
