class Game
  def initialize(counters)
    @counters = counters
  end
  
  def active_counters
    @counters
  end
  
  def play
    offspring = find_empty_neighbors.select do |cell|
      neighbors = find_neighbors(cell)
      neighbors.size == 3
    end
    survivors = @counters.select do |counter|
      neighbors = find_neighbors(counter)
      neighbors.size >= 2 && neighbors.size < 4
    end
    @counters = survivors + offspring
  end
  
private
  def find_neighbors(counter)
    @counters.select do |candidate|
      delta_x = (candidate[:x] - counter[:x]).abs
      delta_y = (candidate[:y] - counter[:y]).abs
      delta_x ^ delta_y == 1 || delta_x * delta_y == 1
    end
  end
  
  def find_candidate_neighbors(cell)
    [
      {x: cell[:x] - 1, y: cell[:y]},
      {x: cell[:x], y: cell[:y] - 1},
      {x: cell[:x] + 1, y: cell[:y]},
    ]
  end
  
  def find_empty_neighbors
    @counters.
      map {|cell| find_candidate_neighbors(cell)}.
      flatten.
      uniq.
      reject {|cell| @counters.include?(cell)}
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
  
  context "underpopulation rule do" do
    context "if the cell has no neighbours" do
      before(:each) do
        @game = Game.new([ {x: 0, y: 0} ])
      end
    
      it "should die after a play" do
        @game.play
        expect(@game.active_counters).to be_empty
      end
    end
    
    context "if the cell has 1 neighbour" do
      before(:each) do
        @game = Game.new([ {x: 0, y: 0}, {x: 1, y: 0} ])
      end
    
      it "should die after a play" do
        @game.play
        expect(@game.active_counters).to be_empty
      end
    end
  end
  
  context "survival rule" do
    context "if the cell has 2 neighbors" do
      before(:each) do
        @game = Game.new([ {x: 0, y: 0}, {x: 1, y: 1}, {x: 2, y: 2} ])
      end
      
      it "should survice after a play" do
        @game.play
        expect(@game.active_counters).to eq([ {x: 1, y: 1} ])
      end
    end
    
    context "if the cell has 3 neighbors" do
      before(:each) do
        @game = Game.new([ {x: 0, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}, {x: 2, y: 0} ])
      end
      
      it "should survive after a play" do
        @game.play
        expect(@game.active_counters).to eq([ {x: 1, y: 1}, {x: 1, y: 0}, {x: 0, y: 1}, {x: 2, y: 1} ])
      end
    end
  end
  
  context "overpopulation rule" do
    context "if the cell has 4 neighbors" do
      before(:each) do
        @game = Game.new([ {x: 0, y: 1}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 2, y: 1}, {x: 1, y: 2} ])
      end
      
      it "should die after a play" do
        @game.play
        expect(@game.active_counters).to eq([
          {:x=>0, :y=>1}, {:x=>1, :y=>0}, {:x=>2, :y=>1},
          {:x=>1, :y=>2}, {:x=>0, :y=>0}, {:x=>2, :y=>0},
          {:x=>0, :y=>2}, {:x=>2, :y=>2}
        ])
      end
    end
  end
  
  context "reproduction rule" do
    context "if a dead cell has 3 live neighbors" do
      before(:each) do
        @game = Game.new([ {x: 0, y: 1}, {x: 1, y: 0}, {x: 2, y: 1} ])
      end
      
      it "should come alive" do
        @game.play
        expect(@game.active_counters).to eq([ {x: 1, y: 0}, {x: 1, y: 1} ])
      end
    end
  end
end
