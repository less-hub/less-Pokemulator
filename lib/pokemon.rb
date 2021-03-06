class Pokemon < Obstacles
  attr_accessor :x, :y, :is_fighting, :lvl, :name, :hp, :atk, :def, :spatk, :spdef, :speed, :type

  def initialize(x, y, pokedex_number)
    super(x, y)

    @is_fighting = false

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

    if pokedex_number == 1
      @up1, @up2 = *Gosu::Image.load_tiles(@path_to_image + @image_up, 13, 15)
      @down1, @down2 = *Gosu::Image.load_tiles(@path_to_image + @image_down, 15, 16)
      @left1, @left2 = *Gosu::Image.load_tiles(@path_to_image + @image_left, 19, 15)
      @right1, @right2 = *Gosu::Image.load_tiles(@path_to_image + @image_right, 19, 15)
    elsif pokedex_number == 4
      @up1, @up2 = *Gosu::Image.load_tiles(@path_to_image + @image_up, 11, 17)
      @down1, @down2 = *Gosu::Image.load_tiles(@path_to_image + @image_down, 11, 16)
      @left1, @left2 = *Gosu::Image.load_tiles(@path_to_image + @image_left, 19, 16)
      @right1, @right2 = *Gosu::Image.load_tiles(@path_to_image + @image_right, 19, 16)
    elsif pokedex_number == 7
      @up1, @up2 = *Gosu::Image.load_tiles(@path_to_image + @image_up, 11, 15)
      @down1, @down2 = *Gosu::Image.load_tiles(@path_to_image + @image_down, 11, 15)
      @left1, @left2 = *Gosu::Image.load_tiles(@path_to_image + @image_left, 15, 15)
      @right1, @right2 = *Gosu::Image.load_tiles(@path_to_image + @image_right, 15, 15)
    end

    @cur_image = @down1

    # COMBAT SYSTEM
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

    @lvl = 3

    @hp = 2 * @hp * @lvl / 100 + @lvl + 10

    @atk = calc_stats(@atk)
    @def = calc_stats(@def)
    @spatk = calc_stats(@spatk)
    @spdef = calc_stats(@spdef)
    @speed = calc_stats(@speed)


  end

  def stop
    @is_fighting = true
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

  def update(move_x, move_y)

    unless @is_fighting
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

  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::POKE, @scale_x, @scale_y)
  end

  def calculate_pokemon_size
    if @cur_image == @up1 || @cur_image == @up2
      @width = 13 * @scale_x
      @height = 15 * @scale_y
    elsif @cur_image == @down1 || @cur_image == @down2
      @width = 15 * @scale_x
      @height = 16 * @scale_y
    elsif @cur_image == @left1 || @cur_image == @left2
      @width = 19 * @scale_x
      @height = 15 * @scale_y
    elsif @cur_image == @right1 || @cur_image == @right2
      @width = 19 * @scale_x
      @height = 15 * @scale_y
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

  def dead?
    @hp < 1
  end
end
