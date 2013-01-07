module Nerdword
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
      @pouch.draw(@rack)
    end

    def exchange(tiles)
      @pouch.exchange(tiles, @rack)
    end
  end
end
