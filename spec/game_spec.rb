require "nerdword/player"
require "nerdword/board"
require "nerdword/move"
require "nerdword/position"
require "nerdword/pouch"
require "nerdword/not_random"

module Nerdword
  describe "Game" do
    def positions_for(*rows)
      positions = {}
      rows.each.with_index do |row, i|
        row.each_char.with_index do |col, j|
          unless col == " "
            positions[Position.new(j, i)] = col.to_i
          end
        end
      end
      positions
    end

    # View Game: http://www.scrabble-assoc.com/games/nsc2000/1
    # The game has fUZES scored incorrectly, but we get it right.
    it "plays a whole game" do
      tiles = %w{
        G I N O O T T
        A E O Q R S U
        A I M N O T U
        A E F G I T O
        D E E I L P V
        A A B L Y
        A A D D O
        E E R
        A C E H U
        F I P R W
        M O U
        E I J L N
        E S
        D I N O
        H R Z
        A C E K T T W
        f I S
        a N B
        E G N X
        L R V
        R S Y
        E I
      }

      values = {
        ?A => 1,
        ?B => 3,
        ?C => 3,
        ?D => 2,
        ?E => 1,
        ?F => 4,
        ?G => 2,
        ?H => 4,
        ?I => 1,
        ?J => 8,
        ?K => 5,
        ?L => 1,
        ?M => 3,
        ?N => 1,
        ?O => 1,
        ?P => 3,
        ?Q => 10,
        ?R => 1,
        ?S => 1,
        ?T => 1,
        ?U => 1,
        ?V => 4,
        ?W => 4,
        ?X => 8,
        ?Y => 4,
        ?Z => 10,
        ?a => 0,
        ?f => 0
      }

      letter_multipliers = positions_for(
        "   2       2   ",
        "     3   3     ",
        "      2 2      ",
        "2      2      2",
        "               ",
        " 3   3   3   3 ",
        "  2   2 2   2  ",
        "   2       2   ",
        "  2   2 2   2  ",
        " 3   3   3   3 ",
        "               ",
        "2      2      2",
        "      2 2      ",
        "     3   3     ",
        "   2       2   "
      )

      word_multipliers = positions_for(
        "3      3      3",
        " 2           2 ",
        "  2         2  ",
        "   2       2   ",
        "    2     2    ",
        "               ",
        "               ",
        "3      2      3",
        "               ",
        "               ",
        "    2     2    ",
        "   2       2   ",
        "  2         2  ",
        " 2           2 ",
        "3      3      3"
      )

      shuffle = NotRandom.new
      board = Board.new(values, letter_multipliers, word_multipliers)
      pouch = Pouch.new(tiles, shuffle)

      p1_rack = []
      p2_rack = []
      p1 = Player.new(board, pouch, p1_rack)
      p2 = Player.new(board, pouch, p2_rack)

      moves = [
        Move.new("TOOTING", Position.new(3, 7), Direction::HORIZONTAL),
        Move.new("EQUATORS", Position.new(3, 3), Direction::VERTICAL),
        Move.new("MOUNTAIN", Position.new(8, 4), Direction::VERTICAL),
        Move.new("FOGIE", Position.new(7, 0), Direction::VERTICAL),
        Move.new("LIVED", Position.new(7, 10), Direction::VERTICAL),
        Move.new("BAA", Position.new(2, 8), Direction::VERTICAL),
        Move.new("DOPED", Position.new(9, 1), Direction::VERTICAL),
        Move.new("RELAY", Position.new(1, 5), Direction::VERTICAL),
        Move.new("AHA", Position.new(0, 5), Direction::VERTICAL),
        Move.new("PEWIT", Position.new(4, 10), Direction::VERTICAL),
        Move.new("QUA", Position.new(3, 4), Direction::HORIZONTAL),
        Move.new("FLINT", Position.new(0, 14), Direction::HORIZONTAL),
        Move.new("MEOW", Position.new(1, 12), Direction::HORIZONTAL),
        Move.new("REJOINED", Position.new(6, 13), Direction::HORIZONTAL),
        Move.new("CHEZ", Position.new(12, 11), Direction::VERTICAL),
        Move.new("WACKO", Position.new(5, 3), Direction::VERTICAL),
        Move.new("fUZES", Position.new(10, 14), Direction::HORIZONTAL),
        Move.new("BEN", Position.new(9, 9), Direction::VERTICAL),
        Move.new("SEX", Position.new(10, 4), Direction::VERTICAL),
        Move.new("VAR", Position.new(10, 8), Direction::VERTICAL),
        Move.new("GYRO", Position.new(4, 1), Direction::HORIZONTAL),
        Move.new("DEaLT", Position.new(9, 1), Direction::HORIZONTAL),
        Move.new("SIR", Position.new(11, 5), Direction::VERTICAL),
        Move.new("IT", Position.new(13, 0), Direction::HORIZONTAL)
      ]

      moves.each_slice(2) do |move1, move2|
        p1.draw
        p2.draw
        p1.play(move1)
        p2.play(move2)
      end

      p1_unplayed = values.values_at(*p1_rack).inject(0, :+)

      p1.score.should eq(422)
      (p2.score + p1_unplayed * 2).should eq(409)
    end
  end
end
