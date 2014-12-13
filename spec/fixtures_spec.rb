require File.expand_path 'spec/fixtures'

describe "Fixtures" do
  include Fixtures
  
  describe "#sort_cells" do
    it "sorts values lexicographically" do
      unordered_cells = [
        { :x => 1, :y => 1 },
        { :x => 0, :y => 3 },
        { :x => 1, :y => 2 }
      ]
      ordered_cells = [
        { :x => 0, :y => 3 },
        { :x => 1, :y => 1 },
        { :x => 1, :y => 2 }
      ]
      expect(sort_cells(unordered_cells)).to eq(ordered_cells)
    end
  end
  
  describe "#list_live_cells" do
    it "returns the coordinates of live cells on the board" do
      board = \
        [0,0,0],
        [0,1,0],
        [1,0,0]
      
      expected_cells = [
        { :x => 0, :y => 0 },
        { :x => 1, :y => 1 }
      ]

      expect(sort_cells(list_live_cells(board))).to eq(sort_cells(expected_cells))      
    end
  end
end
