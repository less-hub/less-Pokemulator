class Person < Friendlynpc
  def initialize(x, y, dir, npc_kind)
    super
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
