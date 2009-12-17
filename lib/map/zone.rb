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
  end
end
