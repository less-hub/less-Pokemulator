class Village
  def initialize(village_houses)
    @x = @y = 0

    @village = Array.new

    @house = House.new(200, 200)
    @village.push(@house)

  end

  def draw
    @village.each do |house|
      house.draw
    end
  end

  def new_house(x, y)
    House.new(x, y)
  end

  def colliding_to_houses?(x, y, dir)
    @village.detect { |house| house.collide?(x, y, dir) }
  end

end
