require 'gosu'
require './lib/player'
require './lib/house'

module ZOrder
  BACKGROUND, HOUSE, PLAYER_Z, UI = *0..3
end

WIDTH, HEIGHT = 1920, 1080

class APP_NAME < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = "APP_NAME"

    @background_image = Gosu::Image.new("media/bg.png")

    @player = Player.new(1920/2, 1080/2)

    @house = House.new
  end

  def update
    # --- CLASS PLAYER
    move_y = 0
    move_x = 0

    move_y += 5 if Gosu.button_down? Gosu::KB_K
    move_y -= 5 if Gosu.button_down? Gosu::KB_I

    if move_y == 0
      move_x += 5 if Gosu.button_down? Gosu::KB_L
      move_x -= 5 if Gosu.button_down? Gosu::KB_J
    end

    @player.update(move_x, move_y)

    # --- END PLAYER
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @house.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end


end

APP_NAME.new.show
