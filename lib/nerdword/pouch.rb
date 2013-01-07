module Nerdword
  class Pouch
    def initialize(tiles, rng = Random.new)
      @tiles = tiles
      @rng = rng
    end

    def draw(rack)
      need = 7 - rack.length
      shuffle
      rack.concat(@tiles.shift(need))
    end

    def exchange(tiles, rack)
      remove_tiles(tiles, rack)
      draw(rack)
      @tiles.concat(tiles)
    end

    private

    def shuffle
      @tiles.sort_by! { @rng.rand }
    end

    def remove_tiles(tiles, rack)
      tiles.each do |tile|
        rack.slice!(rack.index(tile))
      end
    end
  end
end
