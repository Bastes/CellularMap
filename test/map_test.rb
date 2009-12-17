require 'test/helper'

class MapTest < Test::Unit::TestCase
  context("In a new map") {
    setup { @map = Map::Map.new }

    context("a random cell") {
      setup { @cell = @map[10, -7] }

      should("have the proper coordinates") {
        assert_equal [10, -7], [@cell.x, @cell.y] }

      should("be equal to itself") {
        assert_equal @map[10, -7], @cell }

      should("be different from another cell") {
        assert_not_equal @map[3, 19], @cell }

      should("have no content") { assert_nil @cell.content }
    }

    context("filling random cells") {
      setup {
        @map[-5, 22] = :something
        @cell1 = @map[-5, 22]

        @map[7, 13] = "something else"
        @cell2 = @map[7, 13]
      }

      should("retrieve stored values") {
        assert_equal :something, @cell1.content
        assert_equal "something else", @cell2.content
      }
    }

    context("starting from a random cell") {
      setup { @cell = @map[3, 8] }

      should("get another cell when added a vector") {
        assert_equal @map[-5, 13], @cell + [-8, 5] }

      should("get another cell when substracted a vector") {
        assert_equal @map[-3, 5], @cell - [6, 3] }
    }
  }
end
