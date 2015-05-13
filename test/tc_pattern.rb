require_relative '../lib/Pattern.rb'
require 'test/unit'

class TestPattern < Test::Unit::TestCase
  
    def test_matrix_bounds
      assert_equal(0,Pattern.new(0,0).channel_nr)
      assert_equal(0,Pattern.new(0,0).channel_nr)
    end
    def test_matrix_size
      pattern = Pattern.new(7,5)
      assert_equal(35,pattern.channel_nr*pattern.steps_nr)
      assert_equal(35,pattern.steps_nr*pattern.channel_nr)
    end
end