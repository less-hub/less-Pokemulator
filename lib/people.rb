class People
  def initialize
    @x = 0
    @y = 0
    @people = []

    @people.push(new_friendPerson(400, 900, :left, 1, 0))
    @people.push(new_friendPerson(800, 900, :down, 0, 1))
  end

  def new_friendPerson(x, y, dir, npc_kind, text_ind)
    FriendPerson.new(x, y, dir, npc_kind, text_ind)
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
