require 'test_helper'

class MashTest < MiniTest::Unit::TestCase
  def test_empty_name_predicate
    mash = Hashie::Mash.new
    assert !mash.name?
  end
  def test_empty_name
    mash = Hashie::Mash.new
    assert_nil mash.name
  end
  def test_set_name
    mash = Hashie::Mash.new
    mash.name = 'Name'
    assert_equal 'Name', mash.name
  end
  def test_set_name_predicate
    mash = Hashie::Mash.new
    mash.name = 'Name'

    assert(mash.name?, "#{mash.name?}")
  end
end