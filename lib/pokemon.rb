class Pokemon
  def initialize(x, y, pokedex_number)
    @x = x
    @y = y
    @speed = 50
    @wait_time = 0

    @dir = :down

    @image_up = "_up.bmp"
    @image_down = "_down.bmp"
    @image_left = "_left.bmp"
    @image_right = "_right.bmp"

    @path_to_image = "media/pokemons/" + pokedex_number.to_s

    @up1, @up2 = *Gosu::Image.load_tiles(@path_to_image + @image_up, 13, 15)
    @down1, @down2 = *Gosu::Image.load_tiles(@path_to_image + @image_down, 15, 16)
    @left1, @left2 = *Gosu::Image.load_tiles(@path_to_image + @image_left, 19, 15)
    @right1, @right2 = *Gosu::Image.load_tiles(@path_to_image + @image_right, 19, 15)

    @cur_image = @down1
  end

  def update(move_x, move_y)

    change_direction

    if move_y > 0
      @cur_image = (Gosu.milliseconds / 350).even? ? @down1 : @down2
    elsif move_y < 0
      @cur_image = (Gosu.milliseconds / 350).even? ? @up1 : @up2
    elsif move_x < 0
      @cur_image = (Gosu.milliseconds / 350).even? ? @left1 : @left2
    elsif move_x > 0
      @cur_image = (Gosu.milliseconds / 350).even? ? @right1 : @right2
    end

    if move_y > 0
      move_y.times { @y += 1 }
    elsif move_y < 0
      move_y = -move_y
      move_y.times { @y -= 1 }
    elsif move_x < 0
      move_x = -move_x
      move_x.times { @x -= 1 }
    elsif move_x > 0
      move_x.times { @x += 1 }
    end

  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::NPC, IMAGE_FACTOR_X, IMAGE_FACTOR_Y)
  end

  def change_direction
    dir = rand(1..4)

    if dir == 1
      @dir = :down
    elsif dir == 2
      @dir = :left
    elsif dir == 3
      @dir = :right
    elsif dir == 4
      @dir = :up
    end
  end

end
