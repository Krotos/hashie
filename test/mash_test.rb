require 'test_helper'

class MashTest < MiniTest::Unit::TestCase
  def setup
    @mash = Hashie::Mash.new
  end

  def test_empty_name_predicate
    assert !@mash.name?
  end

  def test_empty_name
    assert_nil @mash.name
  end

  def test_set_name
    @mash.name = 'Name'
    assert_equal 'Name', @mash.name
  end

  def test_set_name_predicate
    @mash.name = 'Name'
    assert @mash.name?
  end

  def test_bang
    @mash.author!.name = 'Name'
    assert_equal Hashie::Mash, @mash.author.class
  end

  def test_key_predicate
    assert !@mash.key?('some_key')
    @mash.some_key = 'Val'
    assert @mash.key?('some_key')
  end

  def test_nested_keys
    @mash.nested!.nested_2!.nested_3!.name = 'value'
    assert @mash.nested.nested_2.nested_3.name?
    assert_equal 'value', @mash.nested.nested_2.nested_3.name
  end

  def test_under_bang
    assert !@mash.author_.name
  end

  def test_respond_to_missing
    assert !@mash.respond_to?(:name)
    @mash.name = "Name"
    assert @mash.respond_to? :name
  end
end
