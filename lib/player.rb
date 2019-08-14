class Player
  def initialize(x, y)
    @x = x
    @y = y

    @dir= :down

    #Every player frame is 14x19 px
    @walk_down1, @standing_down, @walk_down2 = *Gosu::Image.load_tiles("media/trainer_down.bmp", 70, 90)
    @walk_up1, @standing_up, @walk_up2 = *Gosu::Image.load_tiles("media/trainer_up.bmp", 70, 95)

    @cur_image = @standing_down
  end

  def draw
    if @dir == :down
      offs_y = 25
      factor = 1.0
    elsif @dir == :up
      offs_y = -25
      factor = 1.0
    end

    positi = @y + offs_y

    @cur_image.draw(@x, positi, ZOrder::PLAYER_Z, factor, 1.0)
  end

  def update(move_y)
    if (move_y == 0)
      if @dir == :down
        @cur_image = @standing_down
      elsif @dir == :up
        @cur_image = @standing_up
      end
    elsif (move_y > 0)
      @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk_down1 : @walk_down2
    elsif (move_y < 0)
      @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk_up1 : @walk_up2
    end


    if (move_y > 0)
      @dir = :down
      move_y.times { @y += 1 }
    elsif (move_y < 0)
      @dir = :up
      move_y = -move_y
      move_y.times { @y -= 1 }
    end
  end
end
