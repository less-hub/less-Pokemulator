require 'gosu'
require './lib/player'

module ZOrder
  BACKGROUND, HOUSE, PLAYER_Z, UI = *0..3
end

class FightinGod < Gosu::Window
  def initialize
    super 1920, 1080
    self.caption = "FightinGod"

    @background_image = Gosu::Image.new("media/bg.png")

    @player = Player.new(1920/2, 1080/2)
  end

  def update
    move_y = 0
    move_y += 5 if Gosu.button_down? Gosu::KB_K
    move_y -= 5 if Gosu.button_down? Gosu::KB_I
    @player.update(move_y)
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end


end

FightinGod.new.show
