class Combat
  attr_accessor :pt, :pw, :OFFSET_X, :OFFSET_Y, :combat_text, :pt_name

  def initialize
    @bubble = Gosu::Image.new("media/bubble.png")
    @bubbleWHP = Gosu::Image.new("media/bubble.png")
    @font = Gosu::Font.new(30)

    @OFFSET_X = WIDTH
    @OFFSET_Y = HEIGHT

    @combat_text = "Combattimento iniziato!"

    @x_media = 0
    @y_media = 0
    @loaded = :false

  end

  def update
    if @loaded == :true
      @pt_name = @pt.name
      @pw_name = @pw.name

      @pt_life = @pt.hp.to_s
      @pw_life = @pw.hp.to_s


      @pt_lvl = "LV. #{@pt.lvl.to_s}"
      @pw_lvl = "LV. #{@pw.lvl.to_s}"

      @x_media = (@pt.x + @pw.x) / 2
    else
      @pt_life = "100"
      @pw_life = "100"

      @pt_name = "Lorem"
      @pw_name = "Ipsum"

      @pt_lvl = "LV."
      @pw_lvl = "LV."
    end
  end

  def draw
    @bubble.draw(-@OFFSET_X, -@OFFSET_Y, ZOrder::UI, 2.0, 1.0)
    @font.draw_text(@combat_text, -@OFFSET_X + 10, -@OFFSET_Y + 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)

    @bubbleWHP.draw(-@OFFSET_X + 50, -@OFFSET_Y - 310, ZOrder::UI, 0.3, 0.3)
    @font.draw_text(@pw_life, -@OFFSET_X + 80, -@OFFSET_Y - 280, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text(@pw_name, -@OFFSET_X + 40, -@OFFSET_Y - 350, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text(@pw_lvl, -@OFFSET_X - 30, -@OFFSET_Y - 350, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text("Selvatico", -@OFFSET_X + 40, -@OFFSET_Y - 210, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)

    @bubbleWHP.draw(-@OFFSET_X + 450, -@OFFSET_Y - 310, ZOrder::UI, 0.3, 0.3)
    @font.draw_text(@pt_life, -@OFFSET_X + 480, -@OFFSET_Y - 280, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text(@pt_name, -@OFFSET_X + 440, -@OFFSET_Y - 350, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text(@pt_lvl, -@OFFSET_X + 370, -@OFFSET_Y - 350, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    @font.draw_text("Allenatore", -@OFFSET_X + 440, -@OFFSET_Y - 210, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def player_hits_wild
    if @pt.speed > @pw.speed
      dmg = calculate_trainer_damage(@pt.lvl, @pt.atk, @pw.def, 40)
      dmgw = calculate_trainer_damage(@pw.lvl, @pw.atk, @pt.def, 40)

      @pw.dec_hp_by(dmg)

      unless wpoke_exhausted?
        @pt.dec_hp_by(dmgw)
      end
    else
      dmg = calculate_trainer_damage(@pw.lvl, @pw.atk, @pt.def, 40)
      @pt.dec_hp_by(dmgw)

      unless wpoke_exhausted?
        dmg = calculate_trainer_damage(@pt.lvl, @pt.atk, @pw.def, 40)
        @pw.dec_hp_by(dmg)
      end
    end

    @combat_text = "#{@pt_name} infligge #{dmg} danni e ne riceve #{dmgw}!\n\nTocca a te! Come vuoi procedere?\n\nQ. Attacco da 40"
  end

  def fight_between(poke1, poke2, player)
    @pt = poke1
    @pw = poke2

    @player = player

    if @player.x != @x_media
      @player.move_to(@x_media, @player.y - 1)
    end

    load_fight_ui
    @loaded = :true
  end

  def trainerpoke_give_exp
    @pt.exp += @pt.lvl * 6 / 5

    if @pt.exp > @pt.exp_to_lvl
      @pt.lvl += 1

      @pt.exp -= @pt.exp_to_lvl
    end
  end

  def calculate_trainer_damage(pkm_lvl, pkm_atk, pkm_def, spell_dmg)
    # 40 = SPELL DAMAGE
    ((((2 * pkm_lvl + 10) * pkm_atk * spell_dmg) / (250 * pkm_def) + 2) * rand(0.85..1)).round
  end

  def wpoke_exhausted?
    @pw.dead?
  end

  def reset_text
    @combat_text = "Combattimento iniziato!\n\nCome vuoi procedere?\n\nQ. Attacco da 40"
  end

  def load_fight_ui
    @pt.x = @pw.x + 400
    @pt.y = @pw.y

  end
end
