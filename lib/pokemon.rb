class Pokemon < Obstacles
  def initialize(x, y, pokedex_number)
    super(x, y)

    @x_left_margin = x
    @y_up_margin = y

    @x_right_margin = x + 50
    @y_down_margin = y + 50

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

    calculate_pokemon_size

    if move_y > 0
      move_y.times { @y += 1 } unless out_fence_down?
    elsif move_y < 0
      move_y = -move_y
      move_y.times { @y -= 1 } unless out_fence_up?
    elsif move_x < 0
      move_x = -move_x
      move_x.times { @x -= 1 } unless out_fence_left?
    elsif move_x > 0
      move_x.times { @x += 1 } unless out_fence_right?
    end

  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::NPC, IMAGE_FACTOR_X, IMAGE_FACTOR_Y)
  end

  def calculate_pokemon_size
    if @cur_image == @up1 || @cur_image == @up2
      @width = 13 * IMAGE_FACTOR_X
      @height = 15 * IMAGE_FACTOR_Y
    elsif @cur_image == @down1 || @cur_image == @down2
      @width = 15 * IMAGE_FACTOR_X
      @height = 16 * IMAGE_FACTOR_Y
    elsif @cur_image == @left1 || @cur_image == @left2
      @width = 19 * IMAGE_FACTOR_X
      @height = 15 * IMAGE_FACTOR_Y
    elsif @cur_image == @right1 || @cur_image == @right2
      @width = 19 * IMAGE_FACTOR_X
      @height = 15 * IMAGE_FACTOR_Y
    end
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

  def out_fence_up?
    @y < @y_up_margin
  end

  def out_fence_down?
    @y > @y_down_margin
  end

  def out_fence_left?
    @x < @x_left_margin
  end

  def out_fence_right?
    @x > @x_right_margin
  end

  def collide?(x, y, dir)
    super
  end

end
