class Person < Friendlynpc
  def initialize(x, y, dir)
    super

    @path_to_image = 'media/fnpc1.bmp'

    @look_up, @look_down,
    @look_left, @look_right = *Gosu::Image.load_tiles(@path_to_image, 19, 25)
  end

  def draw
    super
  end

  def update(x, y, dir)
    super
  end

  def colliding_to_fnpc?(x, y, dir)
    super
  end

  def finished_to_talk?
    super
  end

  def npc_says_stuff
    super
  end
end
