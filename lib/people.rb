class People
  def initialize
    @x = 0
    @y = 0
    @people = []

  end

  def new_friendPerson(x, y, dir, npc_kind, map_to_load_x, map_to_load_y, text_ind)
    @people.push(FriendPerson.new(x, y, dir, npc_kind, map_to_load_x, map_to_load_y, text_ind))
  end

  def update(x, y, dir)
    @people.each do |friendPerson|
      friendPerson.update(x, y, dir)
    end
  end

  def draw
    @people.each(&:draw)
  end

  def colliding_to_people?(x, y, dir)
    @people.detect { |friendPerson| friendPerson.colliding_to_fnpc?(x, y, dir) }
  end

end
