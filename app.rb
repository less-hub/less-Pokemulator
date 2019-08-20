# frozen_string_literal: true

require 'gosu'
require './lib/sizes'
require './lib/obstacles'
require './lib/player'
require './lib/house'
require './lib/localmap'
require './lib/street'
require './lib/tree'
require './lib/lake'
require './lib/mapobjects'
require './lib/stone'
require './lib/friendperson'
require './lib/pokemon'
require './lib/trainerpokemon'
require './lib/combat'

module ZOrder
  BACKGROUND, STREET, OBSTACLES, HOUSE, NPC, PLAYER_Z, UI, LOADING = *0..7
end

WIDTH = 1920
HEIGHT = 1080
#  BG EFFECTIVE SIZE:
#     WIDTH: 1920 * 2 = 3840
#     HEIGHT:1080 * 2 = 2160

class APP_NAME < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'APP_NAME'

    @map_position = [0, 0]
    @player_spawn_x = WIDTH / 2
    @player_spawn_y = HEIGHT / 2
    @player_spawn_dir = :down


    @player = Player.new(@player_spawn_x, @player_spawn_y, @player_spawn_dir, @map_position[0], @map_position[1])
    @combat = Combat.new

    # Shows FPS
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)

    @background_image = Gosu::Image.new('media/bg.png')

    @camera_x = [[@player.x - WIDTH / 2, 0].max, WIDTH].min
    @camera_y = [[@player.y - HEIGHT / 2, 0].max, HEIGHT].min
  end

  def update
    unless @player.dies?
      if @player.starts_battle?
        @combat.update
        
        @player.pokemon_defeated? if Gosu.button_down? Gosu::KB_A
      else
        if @player.off_screen_up?
          change_map(:up)
          @player.clear_maps
          @player = Player.new(@player.x, 2 * HEIGHT - 101, :up, @map_position[0], @map_position[1])

        elsif @player.off_screen_down?
          change_map(:down)
          @player.clear_maps
          @player = Player.new(@player.x, 1, :down, @map_position[0], @map_position[1])

        elsif @player.off_screen_left?
          change_map(:left)
          @player.clear_maps
          @player = Player.new(2 * WIDTH - 71, @player.y, :down, @map_position[0], @map_position[1])

        elsif @player.off_screen_right?
          change_map(:right)
          @player.clear_maps
          @player = Player.new(1, @player.y, :down, @map_position[0], @map_position[1])
        else

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
      end
    else
      @player = Player.new(@player_spawn_x, @player_spawn_y, @player_spawn_dir, @map_position[0], @map_position[1])
    end

  end

  def draw
    Gosu.translate(-@camera_x, -@camera_y) do
      @background_image.draw(0, 0, ZOrder::BACKGROUND)
      @player.draw
    end
     @combat.draw
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
    while Gosu.milliseconds - seconds_at_loading < 100
    end
  end


  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def button_up(id)
    if @player.starts_battle?
      case id
      when Gosu::KB_Q
        @combat.player_hits_wild(30)
      when Gosu::KB_W
        puts "W"
      when Gosu::KB_E
        puts "E"
      when Gosu::KB_R
        puts "R"
      end
    end
  end
end

APP_NAME.new.show
