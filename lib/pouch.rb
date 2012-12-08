class Pouch
  def initialize(tiles, rng = Random.new)
    @tiles = tiles
    @rng = rng
  end

  def draw(num)
    shuffle
    @tiles.shift(num)
  end

  private

  def shuffle
    @tiles.sort_by! { @rng.rand }
  end
end
