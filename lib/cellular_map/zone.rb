module CellularMap
  # =Map zones
  #
  # Zones are generated on the fly to provide a wrapper to keep a map's zone
  # under surveillance.
  #
  # (see README for examples)
  class Zone
    include Enumerable

    # Zone's boundaries
    attr_reader :x, :y
    # Map the zone's part of
    attr_reader :map

    def initialize(x, y, map) # :nodoc:
      @x, @y = rangeize(x, y)
      @map = map
    end

    # Zone's length.
    def length
      width * height
    end

    # Zone's width.
    def width
      @x.count
    end

    # Zone's height.
    def height
      @y.count
    end

    # Access to a cell inside the zone.
    def [](x, y)
      @map[*relative(x, y)]
    end

    # Modification of a cell's content inside the zone.
    def []=(x, y, content)
      @map[*relative(x, y)] = content
    end

    def ==(other) # :nodoc:
      ! self.detect { |c| ! (other.map[c.x, c.y].content == c.content) }
    end

    # Iterating over each cells inside the zone.
    #
    # (first to last lines, first to last columns for each line)
    def each # :yields: cell
      @y.each { |y| @x.each { |x| yield Cell.new(x, y, @map) } }
      self
    end

    # Making an array of arrays of all cells inside the zone.
    #
    # see each
    def to_a
      @y.collect { |y| @x.collect { |x| Cell.new(x, y, @map) } }
    end

    protected

    # Converts coordinates to coordinates relative to inside the map.
    def relative(x, y)
      if x.respond_to?(:to_i) && y.respond_to?(:to_i)
        [@x.min + x.to_i, @y.min + y.to_i]
      else
        x, y = rangeize(x, y)
        [ (@x.min + x.min)..(@x.min + x.max),
          (@y.min + y.min)..(@y.min + y.max) ]
      end
    end

    # Converts given coordinates to ranges if necessary.
    def rangeize(x, y)
      [x, y].collect { |i| i.respond_to?(:to_i) ? (i.to_i..i.to_i) : i }
    end

    def initialize_copy(other) # :nodoc:
      @map = other.map.dup
      @map.each { |c| c.content = nil unless x === c.x && y === c.y }
    end
  end
end
