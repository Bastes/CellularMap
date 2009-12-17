require 'test/helper'

class ZoneTest < Test::Unit::TestCase
  context("In a map") {
    setup { @map = Map::Map.new }

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
    }
  }
end
