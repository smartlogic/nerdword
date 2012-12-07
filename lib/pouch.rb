class Pouch
  def initialize(tiles, rng = Random.new)
    @tiles = tiles
    @rng = rng
  end

  def draw(num)
    @tiles.shuffle!(:random => @rng)
    @tiles.shift(num)
  end
end
