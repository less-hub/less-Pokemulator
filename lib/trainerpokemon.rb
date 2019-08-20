class TrainerPokemon
  def initialize(x, y, dir, pokedex_number)
    @x = x
    @y = y
    @dir = dir

    @factor_x = 5.0
    @factor_y = 5.0

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

  def update(move_x, move_y, player_x, player_y)
    if move_y.positive? && move_x.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @down1 : @down2
    elsif move_y.negative? && move_x.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @up1 : @up2
    elsif move_x.positive? && move_y.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @right1 : @right2
    elsif move_x.negative? && move_y.zero?
      @cur_image = (Gosu.milliseconds / 175).even? ? @left1 : @left2
    end

    if move_y.positive?
      @dir = :down

      if @x < player_x + 15
        move_y.times do
          @x += 1
        end
      elsif @x > player_x + 15
        move_y.times do
          @x -= 1
        end

      end

      if @y < player_y - 100
        move_y.times do
           @y += 1
        end
      end

    end

    if move_y.negative?
      @dir = :up

      if @x < player_x + 15
        (-move_y).times do
          @x += 1
        end
      elsif @x > player_x + 15
        (-move_y).times do
          @x -= 1
        end
      end

      if @y > player_y + 120
        (-move_y).times do
           @y -= 1
        end
      end
    end

    if move_x.positive?
      @dir = :right

      if @y < player_y
        move_x.times do
          @y += 1
        end
      elsif @y > player_y
        move_x.times do
          @y -= 1
        end
      end

      if @x < player_x - 100
        move_x.times do
          @x += 1
        end
      end
    end

    if move_x.negative?
      @dir = :left

      if @y < player_y
        (-move_x).times do
          @y += 1
        end
      elsif @y > player_y
        (-move_x).times do
          @y -= 1
        end
      end

      if @x > player_x + 100
        (-move_x).times do
           @x -= 1
        end
      end

    end

  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::NPC, @factor_x, @factor_y)
  end
end
