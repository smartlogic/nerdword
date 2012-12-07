require "player"
require "move"
require "position"

describe Player do
  let(:board) { mock }
  let(:player) { Player.new(board) }

  it "records her score" do
    move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)
    board.stub(:play).with(move).and_return(1)

    player.play(move)

    player.score.should eq(1)
  end
  
  it "add the scores of multiple plays" do
    board.stub(:play).and_return(1)
    
    player.play(stub)
    player.play(stub)

    player.score.should eq(2)
  end
end
