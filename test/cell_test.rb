require 'test/helper'

class CellTest < Test::Unit::TestCase
  context("In a map") {
    setup { @map = Map::Map.new }

    context("a random cell") {
      setup { @cell = @map[10, -7] }

      should("have the proper coordinates") {
        assert_equal [10, -7, @map], [@cell.x, @cell.y, @cell.map] }

      should("be equal to itself") {
        assert_equal @map[10, -7], @cell }

      should("be different from another cell") {
        assert_not_equal @map[3, 19], @cell }

      context("once filled") {
        setup { @cell.content = "anything" }

        should("retrieve its new value") {
          assert_equal "anything", @cell.content }
      }

      should("get another cell when added a vector") {
        assert_equal @map[2, -2], @cell + [-8, 5] }

      should("get another cell when substracted a vector") {
        assert_equal @map[4, -10], @cell - [6, 3] }
    }
  }
end
