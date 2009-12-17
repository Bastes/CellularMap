require 'test/helper'

class MapTest < Test::Unit::TestCase
  context("In a map") {
    setup { @map = Map::Map.new }

    context("a random cell") {
      should("have no content") { assert_nil @map[-3, 15].content }
    }

    context("filling a random cells") {
      setup { @map[-5, 22] = :something }

      should("retrieve stored values") {
        assert_equal :something, @map[-5, 22].content }
    }
  }
end
