class Player
  def initialize(x, y)
    @x = x
    @y = y

    @dir= :down

    #Every player frame is 14x18 px
    @walk_down1, @standing_down, @walk_down2 = *Gosu::Image.load_tiles("media/trainer_down.bmp", 14, 19)
    @walk_up1, @standing_up, @walk_up2 = *Gosu::Image.load_tiles("media/trainer_up.bmp", 14, 19)
    @walk_right1, @standing_right, @walk_right2 = *Gosu::Image.load_tiles("media/trainer_right.bmp", 14, 19)
    @walk_left1, @standing_left, @walk_left2 = *Gosu::Image.load_tiles("media/trainer_left.bmp", 14, 18)

    @cur_image = @standing_down

    @house = House.new
  end

  def draw
    factor_x = 5.0
    factor_y = 5.0

    @cur_image.draw(@x, @y, ZOrder::PLAYER_Z, factor_x, factor_y)
  end

  def update(move_x, move_y)
      if (move_y == 0 && move_x == 0)
        if @dir == :down
          @cur_image = @standing_down
        elsif @dir == :up
          @cur_image = @standing_up
        elsif @dir == :right
          @cur_image = @standing_right
        elsif @dir == :left
          @cur_image = @standing_left
        end
      elsif (move_y > 0 && move_x == 0)
        @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk_down1 : @walk_down2
      elsif (move_y < 0 && move_x == 0)
        @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk_up1 : @walk_up2
      elsif (move_x > 0 && move_y == 0)
        @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk_right1 : @walk_right2
      elsif (move_x < 0 && move_y == 0)
        @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk_left1 : @walk_left2
      end

      if (move_y > 0)
        @dir = :down
        unless do_i_go_off_screen_down?
          move_y.times { @y += 1 }
        end

      elsif (move_y < 0)
        @dir = :up

        if @x <= HOUSE_WIDTH - 15 && @y <= HOUSE_HEIGHT - 80
          move_y = 0
        end

        move_y = -move_y
        unless do_i_go_off_screen_up?
          move_y.times { @y -= 1 }
        end

      elsif (move_x > 0)
        @dir = :right
        unless do_i_go_off_screen_right?
          move_x.times { @x += 1 }
        end

      elsif (move_x < 0)
        @dir = :left

        # HOUSE COLLISION FROM LEFT... FIND OUT WHY RATES ARE
        # LEFT X: +5, LEFT Y: -10
        if @x <= HOUSE_WIDTH - 10 && @y <= HOUSE_HEIGHT - 90
          move_x = 0
        end

        move_x = -move_x
        unless do_i_go_off_screen_left?
          move_x.times { @x -= 1 }
        end

      end

  end

  def do_i_go_off_screen_right?
    # 95 = 70px WIDTH HERO
    @x > WIDTH - 70
  end

  def do_i_go_off_screen_left?
    # OFF_SCREEN LEFT = 0
    @x < 0
  end

  def do_i_go_off_screen_up?
    # OFF_SCREEN UP = 0
    @y < 0
  end

  def do_i_go_off_screen_down?
    # FIND OUT WHY 100
    @y > HEIGHT - 100
  end
end
