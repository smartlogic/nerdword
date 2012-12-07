require "player"

describe Player do
  let(:board) { mock }
  let(:player) { Player.new(board) }

  it "records her score" do
    board.stub(:play).with("CAT").and_return(1)

    player.play("CAT")

    player.score.should eq(1)
  end
  
  it "add the scores of multiple plays" do
    board.stub(:play).and_return(1)
    
    player.play("CAT")
    player.play("COT")

    player.score.should eq(2)
  end
end
