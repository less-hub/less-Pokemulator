# frozen_string_literal: true

require 'gosu'
require './lib/sizes'
require './lib/player'
require './lib/house'
require './lib/localmap'
require './lib/street'
require './lib/tree'
require './lib/lakes'
require './lib/nature'
require './lib/village'
require './lib/stone'
require './lib/friendperson'
require './lib/people'
require './lib/pokemon'
require './lib/wildpokemons'

module ZOrder
  BACKGROUND, STREET, OBSTACLES, HOUSE, NPC, PLAYER_Z, UI, LOADING = *0..7
end

#  BG EFFECTIVE SIZE:
#     WIDTH: 1920 * 2 = 3840
#     HEIGHT:1080 * 2 = 2160

class APP_NAME < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'APP_NAME'

    @map_position = [0, 0]

    @loading_offset_x = 1920
    @loading_offset_y = 1080
    @loading = false

    # Shows FPS
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)

    @background_image = Gosu::Image.new('media/bg.png')

    @player = Player.new(1920 / 2, 1080 / 2, :down, @map_position[0], @map_position[1])

    @camera_x = @camera_y = 0
  end

  def update
    unless @player.dies?
      if @player.do_i_go_off_screen_up?
        change_map(:up)
        @player.clear_maps
        @player = Player.new(@player.x, 2 * HEIGHT - 101, :up, @map_position[0], @map_position[1])

      elsif @player.do_i_go_off_screen_down?
        change_map(:down)
        @player.clear_maps
        @player = Player.new(@player.x, 1, :down, @map_position[0], @map_position[1])

      elsif @player.do_i_go_off_screen_left?
        change_map(:left)
        @player.clear_maps
        @player = Player.new(2 * WIDTH - 71, @player.y, :down, @map_position[0], @map_position[1])

      elsif @player.do_i_go_off_screen_right?
        change_map(:right)
        @player.clear_maps
        @player = Player.new(1, @player.y, :down, @map_position[0], @map_position[1])
      else
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

        # Camera follows player
        @camera_x = [[@player.x - WIDTH / 2, 0].max, WIDTH].min
        @camera_y = [[@player.y - HEIGHT / 2, 0].max, HEIGHT].min
      end
    else
      @player = Player.new(1920 / 2, 1080 / 2, :down, @map_position[0], @map_position[1])
    end
    # --- END PLAYER

  end

  def draw
    Gosu.translate(-@camera_x, -@camera_y) do
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      @player.draw
    end

    Gosu.draw_rect(-@loading_offset_x, -@loading_offset_y, 1920, 1080, Gosu::Color::BLACK, ZOrder::LOADING)
    @font.draw_text(Gosu.fps.to_s, 0, 0, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
  end

  def change_map(player_direction)
    loading_screen(Gosu.milliseconds)

    if player_direction == :up
      @map_position[1] += 1
    elsif player_direction == :down
      @map_position[1] -= 1
    elsif player_direction == :right
      @map_position[0] += 1
    elsif player_direction == :left
      @map_position[0] -= 1
    end
  end

  def loading_screen(seconds_at_loading)
    @start_time = seconds_at_loading

    while Gosu.milliseconds - @start_time < 100
      @loading_offset_x = 0
      @loading_offset_y = 0
    end

    @loading_offset_x = 1920
    @loading_offset_y = 1080
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
