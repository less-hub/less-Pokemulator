class FriendPerson
  def initialize(x, y, dir, npc_kind, text_ind)
    @x = x
    @y = y
    @native_dir = dir
    @dir = dir

    if dir == :down
      @cur_image = @look_down
    elsif dir == :left
      @cur_image = @look_left
    elsif dir == :up
      @cur_image = @look_up
    elsif dir == :right
      @cur_image = @look_right
    end

    @OFFSET_X = 1920
    @OFFSET_Y = 1080

    @path_to_image = "media/trainers/fnpc/" + npc_kind.to_s + ".bmp"

    @look_up, @look_down,
    @look_left, @look_right = *Gosu::Image.load_tiles(@path_to_image, 19, 25)

    @is_talking = false

    @font = Gosu::Font.new(30)
    @text_speech = File.new("media/trainers/fnpc/speech_zone/1.txt")
    @npc_speech = @text_speech.readlines("---")[text_ind]
    @npc_speech.gsub!('---','')

  end

  def draw
    @cur_image.draw(@x, @y, ZOrder::NPC, IMAGE_FACTOR_X - 1.0, IMAGE_FACTOR_Y - 1.0)
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

    if colliding_to_fnpc?(x, y, dir)
      @is_talking = true

      if @is_talking
        @OFFSET_X = -(@x - 150 + FNPC_WIDTH / 2)
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
        @OFFSET_X = 1920
        @OFFSET_Y = 1080

        @dir = @native_dir
      end

      while @is_talking
        npc_says_stuff
        @is_talking = false
      end
    else
      @OFFSET_X = 1920
      @OFFSET_Y = 1080
      @dir = @native_dir
      @is_talking = false
    end
  end

  def colliding_to_fnpc?(x, y, dir)
    if dir == :up
      x <= @x + FNPC_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + FNPC_HEIGHT - AVATAR_D && y >= @y
    elsif dir == :left
      x <= @x + FNPC_WIDTH && x >= @x &&
        y <= @y + FNPC_HEIGHT - AVATAR_E && y >= @y - AVATAR_D
    elsif dir == :down
      x <= @x + FNPC_WIDTH - AVATAR_A && x >= @x - AVATAR_C &&
        y <= @y + FNPC_HEIGHT - AVATAR_E && y >= @y - AVATAR_E
    elsif dir == :right
      x <= @x + FNPC_WIDTH - AVATAR_A && x >= @x - AVATAR_D &&
        y <= @y + FNPC_HEIGHT - AVATAR_E && y >= @y - AVATAR_D
    end
  end

  def finished_to_talk?
    @is_talking
  end

  def npc_says_stuff
    npc_speech = @text_speech.readlines[0]
  end

end
