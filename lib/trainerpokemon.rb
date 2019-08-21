class TrainerPokemon
  attr_accessor :x, :y, :name, :lvl, :hp, :atk, :def, :spatk, :spdef, :speed, :type, :exp, :exp_to_lvl

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

    File.readlines("media/pokemon_stat.txt").each do |phrase|
      phrase.split(" ").each_cons(9) do |num|
        if num[0].to_i == pokedex_number
          @name = num[1]
          @hp = num[2].to_i
          @atk = num[3].to_i
          @def = num[4].to_i
          @spatk = num[5].to_i
          @spdef = num[6].to_i
          @speed = num[7].to_i
          @type = num[8]
        end
      end
    end

    @lvl = 5
    @exp = 123

    @hp = 2 * @hp * @lvl / 100 + @lvl + 10

    @atk = calc_stats(@atk)
    @def = calc_stats(@def)
    @spatk = calc_stats(@spatk)
    @spdef = calc_stats(@spdef)
    @speed = calc_stats(@speed)

    @exp_to_lvl = @lvl**3

  end

  def calc_stats(stat)
    (2 * stat * @lvl / 100) + 5
  end

  def dec_hp_by(atk)
    @hp -= atk

    if @hp < 0
      @hp = 0
    end

  end

  def is_dead?
    @hp < 1
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

      if @y < player_y + 25
        move_x.times do
          @y += 1
        end
      elsif @y > player_y + 25
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

      if @y < player_y + 25
        (-move_x).times do
          @y += 1
        end
      elsif @y > player_y + 25
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
