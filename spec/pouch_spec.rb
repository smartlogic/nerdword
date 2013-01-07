require "nerdword/pouch"
require "nerdword/not_random"

module Nerdword
  describe Pouch do
    it "allows players to draw tiles" do
      pouch = Pouch.new(%w{A B C D E F G}, NotRandom.new)
      rack = []

      pouch.draw(rack)
      rack.should eq(%w{A B C D E F G})
    end

    it "it knows how many tiles are needed" do
      pouch = Pouch.new(%w{A B C D E F G}, NotRandom.new)
      rack = %w{X Y Z}

      pouch.draw(rack)
      rack.should eq(%w{X Y Z A B C D})
    end

    it "stops distributing tiles when empty" do
      pouch = Pouch.new([], NotRandom.new)
      rack = []

      pouch.draw(rack)
      rack.should be_empty
    end

    it "allows players to exchange tiles" do
      tiles = %w{A B C D E F G}
      pouch = Pouch.new(tiles, NotRandom.new)
      rack = %w{T U V W X Y Z}

      pouch.exchange(%w{X Y Z}, rack)

      rack.should eq(%w{T U V W A B C})
    end
  end
end
