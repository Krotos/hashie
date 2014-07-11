require 'test_helper'

class MashTest < MiniTest::Unit::TestCase
  def test_initialize
    assert_equal false, Hashie::Mash.new.nil?
  end
end