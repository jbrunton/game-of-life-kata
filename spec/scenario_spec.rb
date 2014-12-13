describe "Rules" do
  describe "Underpopulation" do
    it "kills single cells" do
      initialize_board \
        [0,0,0],
        [0,1,0],
        [0,0,0]
      tick
      expect_board \
        [0,0,0],
        [0,0,0],
        [0,0,0]
    end
  end
  
  def initialize_board(rows)
    
  end
  
  def list_live_cells(*rows)
    live_cells = []
    rows.each_index do |row_index|
      row = rows[row_index]
      row.each_index do |column_index|
        unless rows[row_index][column_index].zero?
          live_cells.push({ :x => column_index, :y => rows.size - 1 - row_index })
        end
      end
    end
    live_cells
  end
  
  def sort_cells(cells)
    cells.sort do |a, b|
      result = a[:x] <=> b[:x]
      result = b[:y] <=> b[:y] if result.zero?
      result
    end
  end
  
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

      expect(sort_cells(list_live_cells(*board))).to eq(sort_cells(expected_cells))      
    end
  end
end
