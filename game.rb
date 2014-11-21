class Game
  def initialize(initial_cells)
    @active_cells = initial_cells
  end
  
  def active_cells
    @active_cells
  end
  
  def play
    @active_cells = @active_cells.select do |cell|
      neighbor_count(cell) >= 2
    end
  end
  
  def neighbor_count(cell)
    @active_cells.select{ |active_cell| Game.are_neighbors(cell, active_cell) }.size
  end
  
  def self.are_neighbors(cell1, cell2)
    delta_x = (cell1[:x] - cell2[:x]).abs
    delta_y = (cell1[:y] - cell2[:y]).abs
    
    (delta_x + delta_y) > 0 &&
      delta_x <= 1 &&
      delta_y <= 1
  end
end
