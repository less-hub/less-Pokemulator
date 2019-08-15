class Village
  def initialize(village_houses)
    @x = @y = 0

    @village = Array.new

    @house = House.new
    @village.push(@house)

    @house2 = House.new
    @house2.warp(1200, 300)
    @village.push(@house2)

    @house3 = House.new
    @house3.warp(3400, 1700)
    @village.push(@house3)

  end

  def draw
    @village.each do |house|
      house.draw
    end

  end

  def colliding_to_houses?(x, y, dir)
    @village.detect { |house| house.collide?(x, y, dir)}
  end

end
