class Pouch
  def initialize(tiles, rng = Random.new)
    @tiles = tiles
    @rng = rng
  end

  def draw(num)
    shuffle
    @tiles.shift(num)
  end

  def exchange(tiles)
    new_tiles = draw(tiles.length)
    @tiles.concat(tiles)
    new_tiles
  end

  private

  def shuffle
    @tiles.sort_by! { @rng.rand }
  end
end
