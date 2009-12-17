require 'map/cell'

module Map
  # =Map
  # 
  # Maps are limitless, only non-empty (nil content) cells are actually stored.
  #
  # (see README for examples)
  class Map

    # Store of actually filled cells.
    attr_reader :store

    def initialize # :nodoc:
      @store = {}
    end

    # Accessing a cell.
    def [](x, y)
      Cell.new(x, y, self)
    end

    # Putting a new content in a cell.
    def []=(x, y, content)
      if content.nil?
        @store.delete([x, y]) && nil
      else
        @store[[x, y]] = content
      end
    end
  end
end
