# Wild Pokemons spawns with refer point in [0, 0]
# You can create a new pokemon by givinig POKEMON coord to new_pokemon, and then
# insert in @wildpokemons. Example:
#   @wildpokemons.push(new_pokemon(0, 0)) //Spawns a new pokemon in 0,0
#
# NOTE: Spawn pokemons on WildPokemons constructor!

class WildPokemons
  def initialize
    @wildpokemons = []
  end

  def update
    move_y = 0
    move_x = 0

    move_y += 5 if (Gosu.milliseconds / 1750).even?
    move_y -= 5 if (Gosu.milliseconds / 2000).even?
    move_x += 5 if (Gosu.milliseconds / 2250).even?
    move_x -= 5 if (Gosu.milliseconds / 2500).even?

    @wildpokemons.each { |pok| pok.update(move_x, move_y) }
  end

  def draw
    @wildpokemons.each(&:draw)
  end

  # Builds a new pokemon in given position
  # @param: x-axis of pokemon, y-axis of pokemon, pokedex number of pokemon
  # @return: Pokemon at given position
  def new_pokemon(x, y, pokedex_number)
    @wildpokemons.push(Pokemon.new(x, y, pokedex_number))
  end

  # Checks if player hits the pokemon
  # @param: player x-axis, player y-axis, player direction
  # @return: true if player hits ATLEAST 1 pokemon, false otherwise
  def colliding_to_pokemons?(x, y, dir)
    @wildpokemons.detect { |poke| poke.collide?(x, y, dir) }
  end

  def clear
    @wildpokemons.clear
  end

end
