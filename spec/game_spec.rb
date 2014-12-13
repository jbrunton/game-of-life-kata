describe "Game" do
  class Game
    attr_reader :live_cells

    def initialize(initial_cells)
      @live_cells = initial_cells
    end
    
    def tick
      @live_cells = []
    end
  end
  
  context "#initialize" do
    it "initializes the instance" do
      initial_cells = [{ :x => 1, :y => 1 }]
      game = Game.new initial_cells
      expect(game.live_cells).to eq(initial_cells)
    end
  end

  context "if there are no live cells" do
    it "does nothing" do
      game = Game.new []
      game.tick
      expect(game.live_cells).to eq([])
    end
  end
  
  context "#tick" do
    it "kills live cells with fewer than 2 neighbors" do
      game = Game.new [{ :x => 1, :y => 1 }]
      game.tick
      expect(game.live_cells).to_not include({ :x => 1, :y => 1 })
    end
  end
end
