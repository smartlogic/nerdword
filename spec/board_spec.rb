require "board"
require "move"
require "position"

describe Board do
  it "scores a move" do
    values = {
      "C" => 2,
      "A" => 4,
      "T" => 8
    }
    board = Board.new(values)
    score = board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))

    score.should eq(14)
  end

  it "scores a multi-word move" do
    values = {
      "C" => 4,
      "A" => 1,
      "T" => 1,
      "I" => 1,
      "N" => 2
    }
    board = Board.new(values)

    # Move:
    # CAT
    #  TIN

    board.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))
    score = board.play(Move.new("TIN", Position.new(1, 1), Direction::HORIZONTAL))

    score.should eq(8)
  end
end
