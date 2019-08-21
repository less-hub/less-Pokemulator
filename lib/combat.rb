class Combat
  attr_accessor :pt, :pw, :OFFSET_X, :OFFSET_Y, :combat_text, :OFFSET_XWHP, :OFFSET_YWHP

  def initialize
    @bubble = Gosu::Image.new("media/bubble.png")
    @bubbleWHP = Gosu::Image.new("media/bubble.png")
    @font = Gosu::Font.new(30)

    @OFFSET_X = WIDTH
    @OFFSET_Y = HEIGHT

    @OFFSET_XWHP = WIDTH
    @OFFSET_YWHP = HEIGHT

    @combat_text = "Combattimento iniziato!"
    @tp_life = "100"

  end

  def update
    if @loaded == :true
      @pt_name = @pt.name
      @pw_name = @pw.name
      @pt_life = @pt.hp.to_s
      @pw_life = @pw.hp.to_s
    else
      @pt_life = "100"
      @pw_life = "100"
      @pt_name = "Lorem"
      @pw_name = "Ipsum"
    end
  end

  def draw
    @bubble.draw(-@OFFSET_X, -@OFFSET_Y, ZOrder::UI)
    @font.draw_text(@combat_text, -@OFFSET_X + 10, -@OFFSET_Y + 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)

    @bubbleWHP.draw(-@OFFSET_XWHP - 200, -@OFFSET_YWHP - 310, ZOrder::UI, 0.3, 0.3)
    @font.draw_text(@pw_life, -@OFFSET_XWHP - 180, -@OFFSET_YWHP - 280, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text(@pw_name, -@OFFSET_XWHP - 210, -@OFFSET_YWHP - 350, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)

    @bubbleWHP.draw(-@OFFSET_XWHP + 200, -@OFFSET_YWHP - 310, ZOrder::UI, 0.3, 0.3)
    @font.draw_text(@pt_life, -@OFFSET_XWHP + 210, -@OFFSET_YWHP - 280, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text(@pw_name, -@OFFSET_XWHP + 190, -@OFFSET_YWHP - 350, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def player_hits_wild

    @pw.dec_hp_by(30)

    unless wpoke_exhausted?
      @pt.dec_hp_by(10)
    else
      @OFFSET_XWHP = WIDTH
      @OFFSET_YWHP = HEIGHT
    end

    @combat_text = "Il tuo pokemon infligge\n #{30} danni.\n\nTocca a te!,\nCome vuoi procedere?\nQ. Attacco da 30"
  end

  def wpoke_exhausted?
    @pw.dead?
  end

  def fight_between(poke1, poke2, player)
    @pt = poke1
    @pw = poke2

    @player = player

    @loaded = :true
  end

  def reset_text
    @combat_text = "Combattimento iniziato!\n\nCome vuoi procedere?\nQ. Attacco da 30"
  end

  def ask_for_moves
    @combat_text = "Come vuoi procedere?\nQ. Attacco da 30"
  end

  def load_fight_ui
  #  @pw.x = @player.x - 200
  #  @pw.y = @player.y - 90

  #  @pw.update(0, 0)
  end
end
