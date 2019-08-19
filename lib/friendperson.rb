class FriendPerson < Obstacles
  def initialize(x, y, dir, npc_kind, map_to_load_x, map_to_load_y, name, text_ind)
    super(x, y)

    @dir = dir
    @native_dir = dir

    @width = 85
    @height = 120

    @OFFSET_X = WIDTH
    @OFFSET_Y = HEIGHT

    @name = name.capitalize

    @path_to_image = "media/trainers/fnpc/" + npc_kind.to_s + ".bmp"

    @look_up, @look_down,
    @look_left, @look_right = *Gosu::Image.load_tiles(@path_to_image, 19, 25)

    @bubble = Gosu::Image.new("media/bubble.png")

    @path_to_speech = "media/maps/" + map_to_load_x.to_s + map_to_load_y.to_s + "speech.txt"

    @npc_font = Gosu::Font.new(30)
    @npc_speech = File.new(@path_to_speech).readlines("\n\n").map(&:rstrip)[text_ind]
    @npc_speech.gsub!("NAME", "#{@name} dice: ")

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
    @cur_image.draw(@x, @y, ZOrder::NPC, @scale_x - 1.0, @scale_y - 1.0)
    @bubble.draw(-@OFFSET_X, -@OFFSET_Y, ZOrder::UI)
    @npc_font.draw_text(@npc_speech, -@OFFSET_X + 10, -@OFFSET_Y + 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def update(x, y, dir)
    if @dir == :down
      @cur_image = @look_down
    elsif @dir == :left
      @cur_image = @look_left
    elsif @dir == :up
      @cur_image = @look_up
    elsif @dir == :right
      @cur_image = @look_right
    end

    if collide?(x, y, dir)
        @OFFSET_X = -(@x - 150 + @width / 2)
        @OFFSET_Y = -(@y - 350)

        if dir == :right
          @dir = :left
        elsif dir == :left
          @dir = :right
        elsif dir == :up
          @dir = :down
        elsif dir == :down
          @dir = :up
        end
    else
      @OFFSET_X = WIDTH
      @OFFSET_Y = HEIGHT
      @dir = @native_dir
    end
  end

  def warp(x, y)
    super
  end

  def collide?(x, y, dir)
    super
  end

end
