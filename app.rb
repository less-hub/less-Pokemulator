require 'gosu'
require './lib/player'
require './lib/house'
require './lib/village'

module ZOrder
  BACKGROUND, HOUSE, PLAYER_Z, UI = *0..3
end

WIDTH, HEIGHT = 1920, 1080

class APP_NAME < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = "APP_NAME"

    @background_image = Gosu::Image.new("media/bg.png")

    @player = Player.new(1920/2 - 30, 1080/2 - 30)

    @village = Village.new(3)

#    @camera_x = @camera_y = 0

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

#    @camera_x = [@player.x - WIDTH / 2, 0].max
#    @camera_y = [@player.y - HEIGHT / 2, 0].max

    # --- END PLAYER
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @village.draw
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
