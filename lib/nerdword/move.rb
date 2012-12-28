module Nerdword
  class Move
    attr_reader :word, :position, :direction

    def initialize(word, position, direction)
      @word = word
      @position = position
      @direction = direction
    end

    def ==(other)
      [word, position, direction] == [other.word, other.position, other.direction]
    end

    def eql?(other)
      [word, position, direction].eql?[other.word, other.position, other.direction]
    end

    def hash
      [word, position, direction].hash
    end
  end
end
