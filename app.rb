require 'gosu'
require './lib/player'
require './lib/house'
require './lib/village'
require './lib/street'

module ZOrder
  BACKGROUND, STREET, HOUSE, PLAYER_Z, UI = *0..4
end

WIDTH, HEIGHT = 1920, 1080
#BG SIZE AND EFFECTIVE SIZE:
# WIDTH: 1920 * 2 = 3840
# HEIGHT:1080 * 2 = 2160

class APP_NAME < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = "APP_NAME"

    @background_image = Gosu::Image.new("media/bg.png")

    @player = Player.new(1920/2, 1080/2)

    @village = Village.new(3)

    @camera_x = @camera_y = 0

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

    @camera_x = [[@player.x - WIDTH / 2, 0].max, WIDTH].min
    @camera_y = [[@player.y - HEIGHT / 2, 0].max, HEIGHT].min

    # --- END PLAYER
  end

  def draw
    Gosu.translate(-@camera_x, -@camera_y) do
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      @player.draw
      @village.draw
    end
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
