# frozen_string_literal: true

# Spawns the player at given position, who can move around

class Player
  attr_reader :x, :y

  def initialize(x, y, dir, map_to_load_x, map_to_load_y)
    @x = x
    @y = y
    @dir = dir

    @factor_x = 4.0
    @factor_y = 4.0

    @standing_up, @walk_up1, @walk_up2,
      @standing_left, @walk_left1, @walk_left2,
      @standing_down, @walk_down1, @walk_down2,
      @standing_right, @walk_right1, @walk_right2 = *Gosu::Image.load_tiles('media/trainers/main_trainer.bmp', 22, 26)

    @cur_image = @standing_down

    @trainerpokemon = TrainerPokemon.new(@x + 10, @y - 20 * @factor_y, @dir, 1)

    @localmap = LocalMap.new(map_to_load_x, map_to_load_y)
  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::PLAYER_Z, @factor_x, @factor_y)
    @trainerpokemon.draw
    @localmap.draw
  end

  # Makes the player moving around, changes screen if player hits map border
  # @param: player offset x, player offset y
  # @return: NIL
  def update(move_x, move_y)
    if move_y.zero? && move_x.zero?
      if @dir == :down
        @cur_image = @standing_down
      elsif @dir == :up
        @cur_image = @standing_up
      elsif @dir == :right
        @cur_image = @standing_right
      elsif @dir == :left
        @cur_image = @standing_left
      end
    elsif move_y.positive? && move_x.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_down1 : @walk_down2
    elsif move_y.negative? && move_x.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_up1 : @walk_up2
    elsif move_x.positive? && move_y.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_right1 : @walk_right2
    elsif move_x.negative? && move_y.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_left1 : @walk_left2
    end

    @prev_dir = @dir

    # Moves down
    if move_y.positive?
      @dir = :down

      move_y = 0 if @localmap.colliding?(@x, @y, @dir)

      move_y.times do
         @y += 1
      end

    # Moves up
    elsif move_y.negative?
      @dir = :up

      move_y = 0 if @localmap.colliding?(@x, @y, @dir)

      (-move_y).times do
         @y -= 1
      end

    # Moves right
    elsif move_x.positive?
      @dir = :right

      move_x = 0 if @localmap.colliding?(@x, @y, @dir)

      move_x.times do
         @x += 1
      end

    elsif move_x.negative?
      @dir = :left

      move_x = 0 if @localmap.colliding?(@x, @y, @dir)

      (-move_x).times do
         @x -= 1
      end

    end

    @trainerpokemon.update(move_x, move_y, @x, @y)
    @localmap.update(@x, @y, @dir)
  end

  def off_screen_right?
    @x > 2 * WIDTH - 70
  end

  def off_screen_left?
    @x.negative?
  end

  def off_screen_up?
    @y.negative?
  end

  def off_screen_down?
    @y > 2 * HEIGHT - 100
  end

  def dies?
    @localmap.drowned?(@x, @y, @dir)
  end

  def starts_battle?
    @localmap.met_wild_pokemon?(@x, @y, @dir)
  end

  def pokemon_defeated
    @localmap.wild_poke_defeated
  end

  def clear_maps
    @localmap.clear_all
  end

end
