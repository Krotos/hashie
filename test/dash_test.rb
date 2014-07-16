require 'test_helper'

class DashTest < MiniTest::Unit::TestCase
  class Person < Hashie::Dash
    property :name, required: true
    property :email
    property :occupation, default: 'Rubyist'
  end


  def test_init_args_error
    assert_raises(ArgumentError) {Person.new}
    assert_raises(ArgumentError) {Person.new(email: 'mail@mail.com')}
  end

  def test_init_args
    dash_1 = Person.new(name: 'Bob')
    assert_equal 'Bob', dash_1.name
    dash_2 = Person.new(name: 'Bob2', email: 'mail2@mail.com')
    assert_equal 'Bob2', dash_2.name
    assert_equal 'mail2@mail.com', dash_2.email
  end

  def test_set_val
    dash = Person.new(name: 'Sam')
    dash.email = 'mail3@mail.com'
    assert_equal 'Rubyist', dash.occupation
    assert_equal 'mail3@mail.com', dash.email
  end

  def test_required_true
    dash = Person.new(name: 'Bob')
    assert_raises(ArgumentError) {dash.name = nil}
  end

  def test_square_parens
    dash = Person.new(name: 'Bob')
    assert_equal 'Bob', dash[:name]
    assert_raises (NoMethodError) {dash[:key_that_not_exist]}
  end

  def test_square_parens_set_val
    dash = Person.new(name: 'Bob')
    dash[:name] = 'Sam'
    assert_equal 'Sam', dash.name
  end

end