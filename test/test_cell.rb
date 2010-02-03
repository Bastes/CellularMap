require 'test/helper'

class TestCell < Test::Unit::TestCase
  context("In a map") {
    setup { @map = CellularMap::Map.new }

    context("a random cell") {
      setup { @cell = @map[10, -7] }

      should("have the proper coordinates") {
        assert_equal [10, -7, @map], [@cell.x, @cell.y, @cell.map] }

      should("be equal to itself") {
        assert_equal @map[10, -7], @cell }

      should("be different from another cell") {
        assert_not_equal @map[3, 19], @cell }

      should("be different from something else entirely") {
        assert_not_equal :something_else_entirely, @cell
        assert_not_equal 15, @cell
      }

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

  context("An array of cells") {
    setup {
      @map = CellularMap::Map.new
      @sorted = [
        @map[6, -9],
        @map[0, 0],
        @map[0, 5],
        @map[1, 5],
        @map[-4, 7],
        @map[0, 7],
        @map[3, 7],
        @map[3, 8],
      ]
      @cells = [
        @map[3, 8],
        @map[3, 7],
        @map[1, 5],
        @map[0, 0],
        @map[0, 7],
        @map[-4, 7],
        @map[0, 5],
        @map[6, -9],
      ]
      @duplicated = @cells + [
        @map[0, 0],
        @map[1, 5],
      ]
    }

    should("be easy to sort (by rows then by columns)") {
      assert_equal @sorted, @cells.sort }

    should("remove duplicated elements") {
      expected, obtained = [
        @cells,
        @duplicated.uniq
      ].collect { |a| a.collect { |c| [c.x, c.y] }.sort }
      assert_equal expected, obtained
    }
  }
end
