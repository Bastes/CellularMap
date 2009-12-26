require 'test/helper'

class MapTest < Test::Unit::TestCase
  context("An empty map cell") {
    setup { @map = Map::Map.new }

    should("have no content") { assert_nil @map[-3, 15].content }
  }

  context("A map cell filled") {
    setup {
      @map = Map::Map.new
      @map[-5, 22] = :something
    }

    should("retrieve stored values") {
      assert_equal :something, @map[-5, 22].content }
  }

  context("A map with a bunch of cells filled") {
    setup {
      @map = Map::Map.new
      @sample = {
        [1, 2]    => 'once upon a time',
        [35, -4]  => 'there ware a hash',
        [-7, -7]  => :filled_with_random_values,
        [-8, 19]  => %{for example duck or},
        [27, -42] => 42
      }
      @sample.each { |k, v| @map[*k] = v }
    }

    should("loop over all filled cells") {
      inside = {}
      result = @map.each { |cell| inside[[cell.x, cell.y]] = cell.content }
      assert_equal @sample, inside
      assert_equal @map, result
    }
  }
end
