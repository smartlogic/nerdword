class Player
  attr_reader :tiles

  def initialize(board, pouch)
    @board = board
    @pouch = pouch
    @score = 0
    @tiles = []
  end

  def play(word)
    @score += @board.play(word)
  end

  def score
    @score
  end

  def draw
    need = 7 - tiles.length
    tiles.concat(@pouch.draw(need))
  end
end
