# frozen_string_literal: true

require 'gosu'
require './lib/sizes'
require './lib/player'
require './lib/house'
require './lib/city'
require './lib/street'
require './lib/tree'
require './lib/nature'
require './lib/village'
require './lib/stone'
require './lib/friendlynpc'

module ZOrder
  BACKGROUND, STREET, OBSTACLES, HOUSE, NPC, PLAYER_Z, UI = *0..6
end

#  BG EFFECTIVE SIZE:
#     WIDTH: 1920 * 2 = 3840
#     HEIGHT:1080 * 2 = 2160

class APP_NAME < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'APP_NAME'

    # Shows FPS
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)

    @background_image = Gosu::Image.new('media/bg.png')

    @player = Player.new(1920 / 2, 1080 / 2)

    @camera_x = @camera_y = 0
  end

  def draw
    Gosu.translate(-@camera_x, -@camera_y) do
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      @player.draw
    end

    @font.draw_text(Gosu.fps.to_s, 0, 0, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def update
    # --- CLASS PLAYER
    move_y = 0
    move_x = 0

    move_y += 5 if Gosu.button_down? Gosu::KB_K
    move_y -= 5 if Gosu.button_down? Gosu::KB_I

    if move_y.zero?
      move_x += 5 if Gosu.button_down? Gosu::KB_L
      move_x -= 5 if Gosu.button_down? Gosu::KB_J
    end

    @player.update(move_x, move_y)


    # --- END PLAYER

    # Camera follows player
    @camera_x = [[@player.x - WIDTH / 2, 0].max, WIDTH].min
    @camera_y = [[@player.y - HEIGHT / 2, 0].max, HEIGHT].min
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
