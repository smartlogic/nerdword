require "player"
require "board"
require "move"
require "position"
require "pouch"

describe "Game" do
  it "plays a round" do
    values = {
      "P" => 4,
      "O" => 1,
      "I" => 1,
      "S" => 1
    }

    board = Board.new(values)
    pouch = Pouch.new(%w{I O C A S B P S O D E}, Random.new(1))

    p1 = Player.new(board, pouch)
    p2 = Player.new(board, pouch)

    p1.draw
    p2.draw

    p1.play(Move.new("POO", Position.new(0, 0), Direction::HORIZONTAL))
    p2.play(Move.new("PISS", Position.new(0, 0), Direction::VERTICAL))

    p1.score.should == 6
    p2.score.should == 7
  end
end
