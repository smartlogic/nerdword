module Nerdword
  class Board
    def initialize(values, letter_multipliers = {}, word_multipliers = {})
      @values = values
      @letter_multipliers = letter_multipliers
      @word_multipliers = word_multipliers
      @history = []
    end

    def play(move, rack)
      index = generate_index(@history)
      moves = find_moves(move, index)
      @history << move
      score = moves.inject(0) { |score, move| score + score_move(move, index) }
      tiles_used = calculate_tiles_used(move, index)
      tiles_used.each do |tile|
        rack.slice!(rack.index(tile))
      end
      if tiles_used.length == 7
        score += 50
      end
      score
    end

    private

    def find_moves(move, index)
      moves = [move]

      direction = move.direction
      orthogonal_direction = Direction.opposite(direction)

      move.word.length.times do |i|
        current = move.position.shift(i, direction)
        next if index[current] # not placed by us, so don't look for adjacent letters

        behind = current.previous(orthogonal_direction)
        ahead = current.next(orthogonal_direction)

        if index[behind] || index[ahead]
          total_index = generate_index(@history + [move])
          move_start = find_move_start(current, orthogonal_direction, total_index)
          prefix = Move.new(total_index[move_start], move_start, orthogonal_direction)
          moves << find_move(prefix, total_index)
        end
      end

      moves
    end

    def find_move_start(position, direction, index)
      prev = position.previous(direction)

      if index[prev]
        find_move_start(prev, direction, index)
      else
        position
      end
    end

    def find_move(prefix, index)
      ahead = prefix.position.shift(prefix.word.length, prefix.direction)

      if index[ahead]
        find_move(Move.new(prefix.word + index[ahead], prefix.position, prefix.direction), index)
      else
        prefix
      end
    end

    def generate_index(history)
      index = {}

      history.each do |move|
        move.word.each_char.with_index do |char, i|
          index[move.position.shift(i, move.direction)] = move.word[i]
        end
      end

      index
    end

    def score_move(move, index)
      word_multiplier = 1
      score = move.word.each_char.with_index.inject(0) do |score, (c, i)|
        pos = move.position.shift(i, move.direction)
        if index[pos]
          score + @values[c]
        else
          word_multiplier *= @word_multipliers.fetch(pos, 1)
          score + @values[c] * @letter_multipliers.fetch(pos, 1)
        end
      end * word_multiplier
      score
    end

    def calculate_tiles_used(move, index)
      used = []
      move.word.each_char.with_index do |char, i|
        next if index[move.position.shift(i, move.direction)]
        used << char
      end

      used
    end
  end
end
