require "board"

describe Board do
  it "scores a move" do
    values = {
      "C" => 2,
      "A" => 4,
      "T" => 8
    }
    board = Board.new(values)
    score = board.play("CAT")

    score.should eq(14)
  end
end
