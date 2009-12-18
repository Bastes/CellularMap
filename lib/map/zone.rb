module Map
  # =Map zones
  #
  # Zones are generated on the fly to provide a wrapper to keep a map's zone
  # under surveillance.
  #
  # (see README for examples)
  class Zone
    
    # Zone's boundaries
    attr_reader :x, :y
    # Map the zone's part of
    attr_reader :map

    def initialize(x, y, map) # :nodoc:
      @x = x.respond_to?(:to_i) ? (x.to_i..x.to_i) : x
      @y = y.respond_to?(:to_i) ? (y.to_i..y.to_i) : y
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
      if x.respond_to?(:to_i) && y.respond_to?(:to_i)
        @map[@x.min + x.to_i, @y.min + y.to_i]
      else
        x = x.to_i..x.to_i if x.respond_to?(:to_i)
        y = y.to_i..y.to_i if y.respond_to?(:to_i)
        @map[(@x.min + x.min)..(@x.min + x.max),
             (@y.min + y.min)..(@y.min + y.max)]
      end
    end

    def ==(other) # :nodoc:
      [@x, @y, @map] == [other.x, other.y, other.map]
    end

    # Iterating over each cells inside the zone.
    #
    # (first lines, then columns)
    def each # :yields: cell
      @y.each { |y| @x.each { |x| yield Cell.new(x, y, @map) } }
    end
  end
end
