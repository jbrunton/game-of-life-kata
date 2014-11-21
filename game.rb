class Game
  def initialize(initial_cells)
    @active_cells = initial_cells
  end
  
  def active_cells
    @active_cells
  end
  
  def play
    survivors = @active_cells.select{ |cell| active_neighbor_count(cell) >= 2 }
    offspring = @active_cells.map{ |cell| empty_neighbors_of(cell) }.
      flatten.
      uniq.
      select{ |cell| active_neighbor_count(cell) >= 3 }
    @active_cells = (survivors + offspring).uniq
  end
  
  def active_neighbor_count(cell)
    @active_cells.select{ |active_cell| Game.are_neighbors(cell, active_cell) }.size
  end
  
  def empty_neighbors_of(cell)
    empty_neighbors = []
    [-1,0,1].each do |offset_x|
      [-1,0,1].each do |offset_y|
        unless offset_x.zero? && offset_y.zero?
          candidate_cell = {x: cell[:x] + offset_x, y: cell[:y] + offset_y}
          empty_neighbors.push(candidate_cell) unless @active_cells.include?(candidate_cell)
        end
      end
    end
    empty_neighbors
  end
  
  def self.are_neighbors(cell1, cell2)
    delta_x = (cell1[:x] - cell2[:x]).abs
    delta_y = (cell1[:y] - cell2[:y]).abs
    
    (delta_x + delta_y) > 0 &&
      delta_x <= 1 &&
      delta_y <= 1
  end
end
