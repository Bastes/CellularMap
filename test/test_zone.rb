require 'test/helper'

class TestZone < Test::Unit::TestCase
  context("In a map") {
    setup { @map = CellularMap::Map.new }

    context("a random zone") {
      setup { @zone = @map[-1..7, -3..2] }

      should("have the right amount of cells") { assert_equal 54, @zone.length }

      should("have the right dimensions") {
        assert_equal [9, 6], [@zone.width, @zone.height] }

      should("have the right boundaries") {
        assert_equal [-1..7, -3..2, @map], [@zone.x, @zone.y, @zone.map] }

      should("allow access to cells relatively to boundaries") {
        assert_equal @map[2, 1], @zone[3, 4] }

      should("allow access to other zones relatively to boundaries") {
        assert_equal @map[-2..5, 6..11], @zone[-1..6, 9..14] }

      should("allow to fill cells relatively to its boundaries") {
        @zone[2, 1] = 'thingy'
        assert_equal 'thingy', @zone[2, 1].content
        assert_equal 'thingy', @map[1, -2].content
      }
    }

    context("with a few filled cells") {
      setup {
        @sample = {
          [3, -9]  => 'blah blah',
          [17, 5]  => %{lorem ispum},
          [-1, 4]  => 123,
        }
        @sample.merge({
          [53, 11] => /dolor sid amet/,
          [7, -22] => 0..11
        }).each { |k, v| @map[*k] = v }
        @sort_order = lambda { |a, b| (a[0] <=> b[0]) * 2 + (a[1] <=> b[1]) }
      }

      context("a certain zone") {
        setup {
          @range = -20..20
          @positions = @range.to_a.collect { @range.to_a }.flatten.
            zip(@range.to_a.collect{ |v| @range.to_a.collect { v } }.flatten)
          @zone = @map[@range, @range]
        }

        should("loop over all cells it contains") {
          inside = []
          @zone.each { |cell|
            pos = [cell.x, cell.y]
            assert_equal @sample[pos], cell.content
            inside << pos
          }
          assert_equal @positions, inside
        }

        should("return itself after iterating") {
          result = @zone.each {}
          assert_same @zone, result
        }

        should("collect all its cells in a basic one-dimension array") {
          inside, outside = [
            @zone.collect { |cell| [cell.x, cell.y, cell.content] },
            @positions.collect { |x, y| [x, y, @sample[[x, y]]] }
          ].collect { |a| a.sort &@sort_order }
          assert_equal outside, inside
        }

        should("inject its cells in a result") {
          inside, outside = [
            @zone.inject([]) { |r, c| r + [[c.x, c.y, c.content]] },
            @positions.collect { |x, y| [x, y, @sample[[x, y]]] }
          ].collect { |a| a.sort &@sort_order }
          assert_equal outside, inside
        }

        should("be convertible to an array of all its cells") {
          res = @zone.to_a
          assert res.is_a? Array
          assert res.collect { |r| r.is_a? Array }.inject { |a, b| a && b }
          assert res.collect { |r| r.collect { |c| c.is_a? CellularMap::Cell }}.
            flatten.inject { |a, b| a && b }
          inside = []
          res.each { |row| row.each { |cell|
            pos = [cell.x, cell.y]
            assert_equal @sample[pos], cell.content
            inside << pos
          } }
          assert_equal @positions, inside
        }

        context("and its duplicate") {
          setup { @duplicate = @zone.dup }
          should("be identical") { assert_equal @zone, @duplicate }
          should("not be the same instance") {
            assert_not_same @zone, @duplicate }
          should("not be on the same map") {
            assert_not_same @zone.map, @duplicate.map }
          should("have duplicated only the cells inside the zone") {
            expected, obtained = [
              @duplicate.map.to_a,
              @duplicate.reject { |c| c.content.nil? }
            ].collect { |a|
              a.collect { |c| [c.x, c.y, c.content] }.sort &@sort_order }
            assert_equal expected, obtained
          }
        }
      }
    }
  }
end
