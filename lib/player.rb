# frozen_string_literal: true

# Spawns the player at given position, who can move around

class Player
  attr_reader :x, :y

  def initialize(x, y, dir, map_to_load_x, map_to_load_y)
    @x = x
    @y = y
    @dir = dir
    @prev_dir = @dir

    @factor_x = 4.0
    @factor_y = 4.0

    @standing_up, @walk_up1, @walk_up2,
      @standing_left, @walk_left1, @walk_left2,
      @standing_down, @walk_down1, @walk_down2,
      @standing_right, @walk_right1, @walk_right2 = *Gosu::Image.load_tiles('media/trainers/main_trainer.bmp', 22, 26)

    @cur_image = @standing_down

    #@trainerpokemon = TrainerPokemon.new(x, y, dir)

    @image_up = "_up.bmp"
    @image_down = "_down.bmp"
    @image_left = "_left.bmp"
    @image_right = "_right.bmp"


    @path_to_poke = "media/pokemons/1"
    @up1, @up2 = *Gosu::Image.load_tiles(@path_to_poke + @image_up, 13, 15)
    @down1, @down2 = *Gosu::Image.load_tiles(@path_to_poke + @image_down, 15, 16)
    @left1, @left2 = *Gosu::Image.load_tiles(@path_to_poke + @image_left, 19, 15)
    @right1, @right2 = *Gosu::Image.load_tiles(@path_to_poke + @image_right, 19, 15)

    @pok_x = x + 10
    @pok_y = y - 20 * @factor_y
    @pok_cur_image = @down1

    @localmap = LocalMap.new(map_to_load_x, map_to_load_y)
  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::PLAYER_Z, @factor_x, @factor_y)
    @localmap.draw

    @pok_cur_image.draw(@pok_x, @pok_y, ZOrder::PLAYER_Z, @factor_x + 1, @factor_y + 1)
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
      @pok_cur_image = (Gosu.milliseconds / 175).even? ? @down1 : @down2
    elsif move_y.negative? && move_x.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_up1 : @walk_up2
      @pok_cur_image = (Gosu.milliseconds / 175).even? ? @up1 : @up2
    elsif move_x.positive? && move_y.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_right1 : @walk_right2
      @pok_cur_image = (Gosu.milliseconds / 175).even? ? @right1 : @right2
    elsif move_x.negative? && move_y.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @walk_left1 : @walk_left2
      @pok_cur_image = (Gosu.milliseconds / 175).even? ? @left1 : @left2
    end

    @prev_dir = @dir

    # Moves down
    if move_y.positive?
      @dir = :down

      if @dir != @prev_dir
        @pok_x = @x + 20
        @pok_y = @y - 20 * @factor_y
      end

      move_y = 0 if @localmap.colliding?(@x, @y, @dir)

      move_y.times do
         @y += 1

         @pok_y += 1
      end

    # Moves up
    elsif move_y.negative?
      @dir = :up

      if @dir != @prev_dir
        @pok_x = @x + 20
        @pok_y = @y + 30 * @factor_y
      end

      move_y = 0 if @localmap.colliding?(@x, @y, @dir)

      move_y = -move_y
      move_y.times do
         @y -= 1
         @pok_y -= 1
      end

    # Moves right
    elsif move_x.positive?
      @dir = :right

      if @dir != @prev_dir
        @pok_x = @x - 30 * @factor_x
        @pok_y = @y + 20
      end

      move_x = 0 if @localmap.colliding?(@x, @y, @dir)

      move_x.times do
         @x += 1
         @pok_x += 1
      end

    elsif move_x.negative?
      @dir = :left

      if @dir != @prev_dir
         @pok_x = @x + 30 * @factor_x
         @pok_y = @y + 20
      end

      move_x = 0 if @localmap.colliding?(@x, @y, @dir)

      move_x = -move_x

      move_x.times do
         @x -= 1
         @pok_x -= 1
      end

      end

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

  def clear_maps
    @localmap.clear_all
  end

end
