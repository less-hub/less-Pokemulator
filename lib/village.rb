class Village
  def initialize(village_houses)
    @x = @y = 0

    @village = Array.new
    @streets = Array.new

    @house = House.new
    @street = Street.new(@house.x + 50, @house.y + HOUSE_HEIGHT - 20)
    @village.push(@house)
    @streets.push(@street)

    @house2 = House.new
    @house2.warp(1200, 300)
    @street2 = Street.new(@house2.x + 50, @house2.y + HOUSE_HEIGHT - 20)
    @village.push(@house2)
    @streets.push(@street2)

    @house3 = House.new
    @house3.warp(3400, 1700)
    @village.push(@house3)

  end

  def draw
    @village.each do |house|
      house.draw
    end

    @streets.each do |street|
      street.draw
    end

  end

  def colliding_to_houses?(x, y, dir)
    @village.detect { |house| house.collide?(x, y, dir)}
  end

end
