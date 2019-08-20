class Combat
  attr_accessor :pt, :pw, :OFFSET_X, :OFFSET_Y, :combat_text

  def initialize
    @bubble = Gosu::Image.new("media/bubble.png")
    @font = Gosu::Font.new(30)

    @OFFSET_X = WIDTH
    @OFFSET_Y = HEIGHT

    @combat_text = "Combattimento iniziato!"

  end

  def update

  end

  def draw
    @bubble.draw(-@OFFSET_X, -@OFFSET_Y, ZOrder::UI)
    @font.draw_text(@combat_text, -@OFFSET_X + 10, -@OFFSET_Y + 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def player_hits_wild(atk)
    @pw.dec_hp_by(atk)

    unless wpoke_exhausted?
      @pt.dec_hp_by(atk)
    end


    @combat_text = "Il tuo pokemon infligge\n #{atk} danni.\n\n Come vuoi procedere?\nQ. Attacco da 30"
  end

  def wpoke_exhausted?
    @pw.dead?
  end

  def fight_between(poke1, poke2)
    @pt = poke1
    @pw = poke2
  end

  def reset_text
    @combat_text = "Combattimento iniziato!\n\nCome vuoi procedere?\nQ. Attacco da 30"
  end

  def ask_for_moves
    @combat_text = "Come vuoi procedere?\nQ. Attacco da 30"
  end
end
