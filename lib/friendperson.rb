class FriendPerson < Obstacles
  def initialize(x, y, dir, npc_kind, map_to_load_x, map_to_load_y, text_ind)
    super(x, y)

    @dir = dir
    @native_dir = dir

    @width = 85
    @height = 120

    @OFFSET_X = WIDTH
    @OFFSET_Y = HEIGHT

    @path_to_image = "media/trainers/fnpc/" + npc_kind.to_s + ".bmp"

    @look_up, @look_down,
    @look_left, @look_right = *Gosu::Image.load_tiles(@path_to_image, 19, 25)


    @path_to_speech = "media/trainers/fnpc/speech_zone/" + map_to_load_x.to_s + map_to_load_y.to_s + ".txt"

    @font = Gosu::Font.new(30)
    @npc_speech = File.new(@path_to_speech).readlines("---")[text_ind]
    @npc_speech.gsub!('---','')

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
    Gosu.draw_rect(-@OFFSET_X, -@OFFSET_Y, 300, 300, Gosu::Color::WHITE, ZOrder::UI)
    @font.draw_text(@npc_speech, -@OFFSET_X, -@OFFSET_Y, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
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
