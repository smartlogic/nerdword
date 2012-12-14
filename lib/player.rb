class Player
  attr_reader :tiles

  def initialize(board, pouch)
    @board = board
    @pouch = pouch
    @score = 0
    @tiles = []
  end

  def play(move)
    score, tiles_used = @board.play(move)
    @score += score
    tiles_used.each do |tile|
      @tiles.slice!(@tiles.index(tile))
    end
  end

  def score
    @score
  end

  def draw
    need = 7 - tiles.length
    tiles.concat(@pouch.draw(need))
  end

  def exchange(tiles)
    @tiles = @tiles - tiles
    @tiles.concat(@pouch.exchange(tiles))
  end
end
