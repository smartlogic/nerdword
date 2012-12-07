class Player
  def initialize(board)
    @board = board
    @score = 0
  end

  def play(word)
    @score += @board.play(word)
  end

  def score
    @score
  end
end
