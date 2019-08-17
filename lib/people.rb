class People
  def initialize
    @x = 0
    @y = 0
    @people = []

    @people.push(new_person(400, 900, :left, 1))
    @people.push(new_person(800, 900, :down, 0))
  end

  def new_person(x, y, dir, npc_kind)
    Person.new(x, y, dir, npc_kind)
  end

  def update(x, y, dir)
    @people.each do |person|
      person.update(x, y, dir)
    end
  end

  def draw
    @people.each(&:draw)
  end

  def colliding_to_people?(x, y, dir)
    @people.detect { |person| person.colliding_to_fnpc?(x, y, dir) }
  end

end
