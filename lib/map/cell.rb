module Map
  # =Map cells
  #
  # Cells are generated on the fly to provide a wrapper to access to the map's
  # content in a more user-friendly way.
  #
  # (see README for examples)
  class Cell

    # Cell's coordinates.
    attr_reader :x, :y
    # Map the cell's a part of.
    attr_reader :map

    def initialize(x, y, map) # :nodoc:
      @x = x
      @y = y
      @map = map
    end
    
    # Cell's content.
    def content
      @map.store[[x, y]]
    end

    # Setting new content in the cell.
    def content=(content)
      @map[@x, @y] = content
    end

    def ==(other) # :nodoc:
      [@x, @y, @map] == [other.x, other.y, other.map]
    end

    # Selecting a related cell through a vector movement.
    def +(vector)
      Cell.new(@x + vector.first, @y + vector.last, @map)
    end

    # Selecting a related cell through a vector movement.
    def -(vector)
      self + vector.collect { |v| -v }
    end
  end
end
