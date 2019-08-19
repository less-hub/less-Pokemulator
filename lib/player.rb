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

    @localmap = LocalMap.new(map_to_load_x, map_to_load_y)
  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::PLAYER_Z, @factor_x, @factor_y)
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

    if move_y.positive?
      @dir = :down

      move_y = 0 if @localmap.colliding?(@x, @y, @dir)

      move_y.times { @y += 1 }

    elsif move_y.negative?
      @dir = :up

      move_y = 0 if @localmap.colliding?(@x, @y, @dir)

      move_y = -move_y
      move_y.times { @y -= 1 }

    elsif move_x.positive?
      @dir = :right

      move_x = 0 if @localmap.colliding?(@x, @y, @dir)

      move_x.times { @x += 1 }

    elsif move_x.negative?
      @dir = :left

      move_x = 0 if @localmap.colliding?(@x, @y, @dir)

      move_x = -move_x
      move_x.times { @x -= 1 }

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
