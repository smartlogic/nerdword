require "nerdword/player"
require "nerdword/move"
require "nerdword/position"

module Nerdword
  describe Player do
    let(:board) { mock }
    let(:pouch) { mock }

    it "draws tiles from the pouch" do
      rack = []
      player = Player.new(board, pouch, rack)

      pouch.should_receive(:draw).with(rack)

      player.draw
    end

    it "exchanges tiles with new ones from the pouch" do
      rack = %w{A B C D E F G}
      player = Player.new(board, pouch, rack)

      pouch.should_receive(:exchange).with(%w{A B C}, rack)

      player.exchange(%w{A B C})
    end

    it "plays a move on the board using her rack" do
      rack = %w{C A T}
      player = Player.new(board, pouch, rack)
      move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)

      board.should_receive(:play).with(move, rack).and_return(0)

      player.play(move)
    end

    it "records her score" do
      player = Player.new(board, pouch)
      move = Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL)
      board.stub(:play).and_return(1)

      player.play(move)

      player.score.should eq(1)
    end

    it "add the scores of multiple plays" do
      player = Player.new(board, pouch)
      board.stub(:play).and_return(1)

      player.play(Move.new("CAT", Position.new(0, 0), Direction::HORIZONTAL))
      player.play(Move.new("COT", Position.new(0, 0), Direction::VERTICAL))

      player.score.should eq(2)
    end
  end
end
