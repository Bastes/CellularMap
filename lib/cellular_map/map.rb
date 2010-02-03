require 'cellular_map/cell'
require 'cellular_map/zone'

module CellularMap
  # =Map
  #
  # Maps are limitless, only non-empty (nil content) cells are actually stored.
  #
  # (see README for examples)
  class Map
    include Enumerable

    # Store of actually filled cells.
    attr_reader :store

    def initialize # :nodoc:
      @store = {}
    end

    # Accessing a cell or a zone.
    def [](x, y)
      if x.respond_to?(:to_i) && y.respond_to?(:to_i)
        Cell.new(x, y, self)
      else
        Zone.new(x, y, self)
      end
    end

    # Putting new content in a cell.
    def []=(x, y, content)
      if content.nil?
        @store.delete([x, y]) && nil
      else
        @store[[x, y]] = content
      end
    end

    # Iterating over each filled cell.
    def each # :yields: cell
      @store.keys.each { |k| yield Cell.new(*(k + [self])) }
      self
    end

    # Empties the map filled cells.
    def empty!
      @store = {}
    end

    def ==(other) # :nodoc:
      @store.length == other.store.length &&
        @store.collect { |k, v| other[*k].content == v }.uniq == [true]
    end

    def initialize_copy(other) # :nodoc:
      @store = {}
      other.each { |c| self[c.x, c.y] = c.content }
    end
  end
end
