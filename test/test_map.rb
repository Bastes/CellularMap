require 'test/helper'

class TestMap < Test::Unit::TestCase
  context("An empty map cell") {
    setup { @map = CellularMap::Map.new }

    should("have no content") { assert_nil @map[-3, 15].content }
  }

  context("A map cell filled") {
    setup {
      @map = CellularMap::Map.new
      @map[-5, 22] = :something
    }

    should("retrieve stored values") {
      assert_equal :something, @map[-5, 22].content }

    context("once emptied") {
      setup { @map[-5, 22] = nil }

      should("stay empty") { assert_equal nil, @map[-5, 22].content }
    }
  }

  context("A map with a bunch of cells filled") {
    setup {
      @map = CellularMap::Map.new
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

    should("be convertible to an array of cells") {
      res = @map.to_a
      assert res.is_a? Array
      assert res.collect { |c| c.is_a? CellularMap::Cell }.
        inject { |a, b| a && b }
      inside = {}
      res.each { |c| inside[[c.x, c.y]] = c.content }
      assert_equal @sample, inside
    }
  }
end
