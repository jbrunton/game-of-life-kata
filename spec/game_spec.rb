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
  
  context ".are_neighbors" do
    it "returns false if the cells aren't horizontal neighbors" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 2, y: 0})).to eq(false)
    end
    
    it "returns false if the cells aren't vertical neighbors" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 0, y: 2})).to eq(false)
    end
    
    it "returns false if the cells aren't diagonal neighbors" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 2, y: 2})).to eq(false)
    end

    it "returns true if the cells are horizontal neighbors" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 1, y: 0})).to eq(true)
    end
    
    it "returns true if the cells are vertical neighbors" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 0, y: 1})).to eq(true)
    end
    
    it "returns true if the cells are diagonal neighbors" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 1, y: 1})).to eq(true)
    end
    
    it "returns false for the reflexive case" do
      expect(Game.are_neighbors({x: 0, y: 0}, {x: 0, y: 0})).to eq(false)
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
  
  context "#empty_neighbors_of" do
    it "returns an empty list when there are no empty neighbors" do
      game = Game.new([
        {x: 0, y:0}, {x: 1, y:0}, {x: 2, y:0},
        {x: 0, y:1},              {x: 2, y:1},
        {x: 0, y:2}, {x: 1, y:2}, {x: 2, y:2}
      ])
      expect(game.empty_neighbors_of({x: 1, y:1})).to be_empty
    end
    
    it "returns a list of empty neighbors" do
      game = Game.new([
                     {x: 1, y:0}, {x: 2, y:0},
        {x: 0, y:1},              {x: 2, y:1},
        {x: 0, y:2}, {x: 1, y:2}, {x: 2, y:2}
      ])
      expect(game.empty_neighbors_of({x: 1, y:1})).to eq([ {x: 0, y:0} ])
    end
  end
end
