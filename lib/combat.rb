class Combat
  attr_accessor :pt, :pw

  def initialize
    @bubble = Gosu::Image.new("media/bubble.png")
    @font = Gosu::Font.new(30)

    @OFFSET_X = WIDTH
    @OFFSET_Y = HEIGHT

  end

  def update
    @OFFSET_X = -300
    @OFFSET_Y = -300
  end

  def draw
    @bubble.draw(-@OFFSET_X, -@OFFSET_Y, ZOrder::UI)
    @font.draw_text("Combattimento iniziato!", -@OFFSET_X + 10, -@OFFSET_Y + 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def player_hits_wild(atk)
    puts "#{10 - atk}"
    # pw.dec_hp_by(atk)
  end

  def poke_exhausted?
    @pw.dead?
  end

  def fight_between(poke1, poke2)
    @pt = poke1
    @pw = poke2
  end
end
