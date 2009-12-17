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
    }
  }
end
