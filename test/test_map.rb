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

    should("return itself after iterating") {
      result = @map.each {}
      assert_same @map, result
    }

    should("collect all filled cells") {
      expected = @sample.collect { |c, v| c + [v] }.sort!
      inside = @map.collect { |cell| [cell.x, cell.y, cell.content] }.sort
      assert_equal expected, inside
    }

    should("inject its filled cells in a result") {
      expected = @sample.collect { |c, v| c + [v] }.sort!
      inside = @map.inject([]) { |r, c| r + [[c.x, c.y, c.content]] }.sort
      assert_equal expected, inside
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

    should("be emptied at will") {
      @map.empty!
      @map.each { |cell| flunk "There should be no more filled cells." }
    }

    context("and its duplicate") {
      setup { @duplicate = @map.dup }
      should("be identical") { assert_equal @map, @duplicate }
      should("not be the same instance") { assert_not_same @map, @duplicate }
      context("evolving") {
        setup {
          @map[5, 2] = :anything
          @duplicate[1, 8] = :blah
        }
        should("have retained their values") {
          assert_equal :anything, @map[5, 2].content
          assert_equal :blah, @duplicate[1, 8].content
        }
        should("not have retained the other one's values") {
          assert_not_equal :blah, @map[1, 8].content
          assert_not_equal :anything, @duplicate[5, 2].content
        }
        should("be different now") { assert_not_equal @map, @duplicate }
      }
    }
  }
end
