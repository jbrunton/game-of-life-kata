class Game
  def initialize(initial_cells)
    @active_cells = initial_cells
  end
  
  def active_cells
    @active_cells
  end
  
  def play
    @active_cells = (survivors + offspring).uniq
  end
  
  def survivors
    @active_cells.select{ |cell| should_survive(cell) }
  end
  
  def offspring
    @active_cells.map{ |cell| neighbors_of(cell) }.
      flatten.
      uniq.
      select{ |cell| should_reproduce(cell) }
  end

  def active_neighbor_count(cell)
    neighbors_of(cell).select{ |neighbor| alive?(neighbor) }.size
  end
  
private
  def neighbors_of(cell)
    NEIGHBOR_OFFSETS.map do |offset_x, offset_y|
      {x: cell[:x] + offset_x, y: cell[:y] + offset_y}
    end
  end

  NEIGHBOR_OFFSETS = [ [-1,-1], [-1, 0], [-1, 1], [0, -1], [0,  1], [1, -1], [1,  0], [1,  1] ]

  def should_survive(cell)
    alive?(cell) && active_neighbor_count(cell).between?(2, 3)
  end
  
  def should_reproduce(cell)
    !alive?(cell) && active_neighbor_count(cell) >= 3
  end
  
  def alive?(cell)
    @active_cells.include?(cell)
  end
end
