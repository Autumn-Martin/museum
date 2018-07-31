require "minitest/autorun"
require "minitest/pride"
require "./lib/patron"

class PatronTest < Minitest::Test
  def setup
    @bob = Patron.new("Bob")
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_it_has_a_name
    assert_equal "Bob", @bob.name
  end

  def test_it_has_default_empty_interests
    assert_equal [], @bob.interests
  end

  def test_interests_can_be_added
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @bob.interests
  end
end
