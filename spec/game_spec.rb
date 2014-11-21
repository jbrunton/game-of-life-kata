class Game
  def initialize(initial_cells)
    @active_cells = initial_cells
  end
  
  def active_cells
    @active_cells
  end
  
  def play
  end
end

describe "Game" do
  context "when the board is empty" do
    it "has no active cells" do
      game = Game.new([])
      expect(game.active_cells).to be_empty
    end
  end
  
  context "when the board is initialized" do
    it "lists the active cells" do
      game = Game.new([ {x: 1, y: 2} ])
      expect(game.active_cells).to eq([ {x: 1, y: 2} ])
    end
  end
  
  context "underpopulation rule" do
    context "if the cell has no neighbors" do
      before(:each) do
        initialize_board \
          [0,0,0],
          [0,1,0],
          [0,0,0]
        play
      end
      
      it "should die after one play" do
        expect_board \
          [0,0,0],
          [0,0,0],
          [0,0,0]
      end
    end
  end
  
  def initialize_board(*rows)
    initial_cells = convert_to_cells(rows)
    @game = Game.new(initial_cells)
  end
  
  def play
    @game.play
  end
  
  def expect_board(*rows)
    expected_cells = convert_to_cells(rows)
    actual_cells = @game.active_cells.sort do |a,b|
      result = a[:y] <=> b[:y]
      result = a[:x] <=> b[:x] if result.zero?
      result
    end
    expect(actual_cells).to eq(expected_cells)
  end
  
  def convert_to_cells(rows)
    cells = []
    rows.each_index do |y|
      rows[y].each_index do |x|
        cells.push({x: x, y: (rows.length - 1) - y}) unless rows[y][x].zero?
      end
    end
    cells
  end
end
