require 'test_helper'

class DashTest < MiniTest::Test
  class Person < Hashie::Dash
    property :name, required: true
    property :email
    property :occupation, default: 'Rubyist'
  end

  def setup
    @dash = Person.new(name: 'Bob')
  end

  def test_init_args_error
    assert_raises(ArgumentError) { Person.new }
    assert_raises(ArgumentError) { Person.new(email: 'mail@mail.com') }
  end

  def test_init_args
    assert_equal 'Bob', @dash.name
    dash_2 = Person.new(name: 'Bob2', email: 'mail2@mail.com')
    assert_equal 'Bob2', dash_2.name
    assert_equal 'mail2@mail.com', dash_2.email
  end

  def test_set_val
    @dash.email = 'mail3@mail.com'
    assert_equal 'Rubyist', @dash.occupation
    assert_equal 'mail3@mail.com', @dash.email
  end

  def test_required_true
    assert_raises(ArgumentError) { @dash.name = nil }
  end

  def test_square_parens
    assert_equal 'Bob', @dash[:name]
    assert_raises (NoMethodError) { @dash[:key_that_not_exist] }
  end

  def test_square_parens_set_val
    @dash[:name] = 'Sam'
    assert_equal 'Sam', @dash.name
    @dash[:occupation] = 'Php-programmer'
    assert_equal 'Php-programmer', @dash[:occupation]
    @dash[:occupation] = nil
    assert_equal 'Rubyist', @dash[:occupation]
  end

  def test_update_attributes_bang
    @dash.update_attributes!(name: 'Trudy', occupation: 'Evil')
    assert_equal 'Evil', @dash.occupation
    assert_equal 'Trudy', @dash.name
    @dash.update_attributes!(occupation: nil)
    assert_equal 'Rubyist', @dash.occupation
  end

  class Tricky < Hashie::Dash
    property :trick
    property 'trick'
  end

  def test_difference_symbol_string
    dash = Tricky.new(trick: 'one', 'trick' => 'two')
    assert_equal 'one', dash.trick
    assert_equal 'one', dash[:trick]
    assert_equal 'two', dash['trick']
  end

  class Dicky < Hashie::Dash
    property 'dick'
  end

  def test_raise_no_method_string
    dash = Dicky.new('dick' => 'two')
    assert_raises (NoMethodError) {dash.dick}
  end
end