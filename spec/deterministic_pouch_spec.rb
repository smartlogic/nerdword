require "deterministic_pouch"

describe DeterministicPouch do
  it "allows players to draw tiles" do
    pouch = DeterministicPouch.new(%w{A B C D E F G})

    draw1 = pouch.draw(4)
    draw2 = pouch.draw(4)

    draw1.should eq(%w{A B C D})
    draw2.should eq(%w{E F G})
  end
end
