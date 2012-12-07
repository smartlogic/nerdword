class DeterministicPouch
  def initialize(tiles)
    @tiles = tiles
  end

  def draw(num)
    @tiles.shift(num)
  end
end
