require_relative File.expand_path('spec/spec_helper')

describe "Game" do
  context "#initialize" do
    it "sets the initially active cells" do
      game = Game.new([ {x: 1, y: 1} ])
      expect(game.active_cells).to eq([ {x: 1, y: 1} ])
    end
  end
  
  context "#play" do
    it "applies a single round of the rules" do
      game = Game.new([ x:1, y: 1])
      game.play
      expect(game.active_cells).to be_empty
    end
  end
  
  context "#active_neighbor_count" do
    it "returns 0 for an empty board" do
      game = Game.new([])
      expect(game.active_neighbor_count({x: 0, y: 0})).to eq(0)
    end
    
    it "returns the number of active neighbors" do
      game = Game.new([ {x: 0, y: 1}, {x: 2, y: 1} ])
      expect(game.active_neighbor_count({x: 1, y: 1})).to eq(2)
    end
  end
end
