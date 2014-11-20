class Game
  def initialize(counters)
    @counters = counters
  end
  
  def active_counters
    @counters
  end
end

describe "Game" do
  context "when the board is empty" do
    it "has no active counters" do
      game = Game.new([])
      expect(game.active_counters).to be_empty
    end
  end
  
  context "when the board is initialized" do
    it "lists the active counters" do
      game = Game.new([ {x: 1, y: 2} ])
      expect(game.active_counters).to eq([ {x: 1, y: 2} ])
    end
  end
end
