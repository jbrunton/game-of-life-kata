describe "Game" do
  class Game
    attr_reader :live_cells

    def initialize(initial_cells)
      @live_cells = initial_cells
    end
    
    def tick
      survivors = @live_cells.select do |cell|
        neighbors = [
          { :x => cell[:x] - 1, :y => cell[:y] },
          { :x => cell[:x] + 1, :y => cell[:y] },
          { :x => cell[:x],     :y => cell[:y] - 1 },
          { :x => cell[:x],     :y => cell[:y] + 1 },
          { :x => cell[:x] - 1, :y => cell[:y] + 1 },
          { :x => cell[:x] + 1, :y => cell[:y] - 1 },
          { :x => cell[:x] + 1, :y => cell[:y] + 1 },
          { :x => cell[:x] - 1, :y => cell[:y] - 1 }
        ]
        live_neighbors = neighbors.select { |neighbor| @live_cells.include?(neighbor) }
        live_neighbors.size.between?(2, 3)
      end
      @live_cells = survivors
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
    
    it "keeps alive cells with 2 horizontal neighbors" do
      game = Game.new [{ :x => 0, :y => 0}, { :x => 1, :y => 0}, { :x => 2, :y => 0}]
      game.tick
      expect(game.live_cells).to include({ :x => 1, :y => 0 })
    end
    
    it "keeps alive cells with 2 vertical neighbors" do
      game = Game.new [{ :x => 0, :y => 0}, { :x => 0, :y => 1}, { :x => 0, :y => 2}]
      game.tick
      expect(game.live_cells).to include({ :x => 0, :y => 1 })
    end
    
    it "keeps alive cells with 2 diagonal neighbors" do
      game = Game.new [{ :x => 0, :y => 1}, { :x => 1, :y => 0}, { :x => 2, :y => 1}]
      game.tick
      expect(game.live_cells).to include({ :x => 1, :y => 0 })
    end
    
    it "keeps alive cells with 3 neighbors" do
      game = Game.new [{ :x => 0, :y => 0}, { :x => 1, :y => 0}, { :x => 2, :y => 0}, { :x => 1, :y => 1 }]
      game.tick
      expect(game.live_cells).to include({ :x => 1, :y => 0 })
    end
  end
end
