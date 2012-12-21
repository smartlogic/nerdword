class Player
  def initialize(board, pouch, rack = [])
    @board = board
    @pouch = pouch
    @score = 0
    @rack = rack
  end

  def play(move)
    @score += @board.play(move, @rack)
  end

  def score
    @score
  end

  def draw
    need = 7 - @rack.length
    @rack.concat(@pouch.draw(need))
  end

  def exchange(tiles)
    remove_tiles(tiles)
    @rack.concat(@pouch.exchange(tiles))
  end

  private

  def remove_tiles(tiles)
    tiles.each do |tile|
      @rack.slice!(@rack.index(tile))
    end
  end
end
