class Friendlynpc
  def initialize(x, y, dir)
    @x = x
    @y = y
    @dir = dir

    @look_up, @look_down = *Gosu::Image.load_tiles('media/fnpc1_updown.bmp', 17, 24)
    @look_left, @look_right = *Gosu::Image.load_tiles('media/fnpc1_leftright.bmp', 16, 24)

    if @dir == :down
      @cur_image = @look_down
    elsif @dir == :left
      @cur_image = @look_left
    elsif @dir == :up
      @cur_image = @look_up
    elsif @dir == :right
      @cur_image = @look_right
    end

  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::NPC, IMAGE_FACTOR_X - 1.0, IMAGE_FACTOR_Y - 1.0)
  end

  def colliding_to_fnpc?(x, y, dir)
    if dir == :up
      x <= @x + FNPC_WIDTH - 25 && x >= @x - 65 &&
        y <= @y + FNPC_HEIGHT - 80 && y >= @y
    elsif dir == :left
      x <= @x + FNPC_WIDTH && x >= @x &&
        y <= @y + FNPC_HEIGHT - 100 && y >= @y - 90
    elsif dir == :down
      x <= @x + FNPC_WIDTH - 25 && x >= @x - 65 &&
        y <= @y + FNPC_HEIGHT - 100 && y >= @y - 100
    elsif dir == :right
      x <= @x + FNPC_WIDTH - 25 && x >= @x - 75 &&
        y <= @y + FNPC_HEIGHT - 100 && y >= @y - 90
    end
  end


end
