# frozen_string_literal: true

# Spawns the player at given position, who can move around

class Player
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @dir = :down

    @factor_x = 4.0
    @factor_y = 4.0

    @standing_up, @walk_up1, @walk_up2,
      @standing_down, @walk_down1, @walk_down2 = *Gosu::Image.load_tiles('media/trainer_up_down.bmp', 19, 28)

    @standing_right, @walk_right1, @walk_right2,
       @standing_left, @walk_left1, @walk_left2 = *Gosu::Image.load_tiles('media/trainer_left_right.bmp', 14, 28)

    @cur_image = @standing_down

    @city = City.new

    @interact_status = false
  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::PLAYER_Z, @factor_x, @factor_y)
    @city.draw
  end

  # Makes the player moving around, stops if hits screen border or houses
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

      move_y = 0 if @city.colliding?(@x, @y, @dir)

      move_y.times { @y += 1 } unless do_i_go_off_screen_down?

    elsif move_y.negative?
      @dir = :up

      move_y = 0 if @city.colliding?(@x, @y, @dir)

      move_y = -move_y
      move_y.times { @y -= 1 } unless do_i_go_off_screen_up?

    elsif move_x.positive?
      @dir = :right

      move_x = 0 if @city.colliding?(@x, @y, @dir)

      move_x.times { @x += 1 } unless do_i_go_off_screen_right?

    elsif move_x.negative?
      @dir = :left

      move_x = 0 if @city.colliding?(@x, @y, @dir)

      move_x = -move_x
      move_x.times { @x -= 1 } unless do_i_go_off_screen_left?

      end

      @city.update(@x, @y, @dir)
  end

  # Will be usefull for map changes, cos checks screen limits
  # @param: NIL
  # @return: true if player goes offscreen, flase otherwise
  def do_i_go_off_screen_right?
    # 95 = 70px WIDTH HERO
    @x > 2 * WIDTH - 70
  end

  def do_i_go_off_screen_left?
    # OFF_SCREEN LEFT = 0
    @x.negative?
  end

  def do_i_go_off_screen_up?
    # OFF_SCREEN UP = 0
    @y.negative?
  end

  def do_i_go_off_screen_down?
    # FIND OUT WHY 100
    @y > 2 * HEIGHT - 100
  end

end
