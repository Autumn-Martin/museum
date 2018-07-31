require "minitest/autorun"
require "minitest/pride"
require "./lib/museum"
require "pry"

class MuseumTest < Minitest::Test
  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_a_name
    assert_equal "Denver Museum of Nature and Science", @dmns.name
  end

  def test_exhibits_can_be_added
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)
    expected = [{"Dead Sea Scrolls" => 10}, {"Gems and Minerals" => 0}]
    assert_equal expected, @dmns.exhibits
  end

  def test_it_initializes_with_no_revenue
    assert_equal 0, @dmns.revenue
  end

  def test_it_can_admit_patrons
    sally = Patron.new("Sally")
    bob = Patron.new("Bob")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal [bob, sally], @dmns.patrons
  end

  def test_revenue_can_be_added
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)
    @dmns.add_exhibit("Imax", 20)

    bob = Patron.new("Bob")

    bob.add_interest("Gems and Minerals")
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Imax")

    sally = Patron.new("Sally")

    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal 40, @dmns.revenue
  end

  def test_it_can_get_patrons_for_an_exhibit
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)
    @dmns.add_exhibit("Imax", 20)

    bob = Patron.new("Bob")

    bob.add_interest("Dead Sea Scrolls")

    sally = Patron.new("Sally")

    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal ["Bob", "Sally"], @dmns.patrons_of("Dead Sea Scrolls")
  end

  def test_it_can_sort_exhibits_by_number_of_patrons
    skip
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)
    @dmns.add_exhibit("Imax", 20)

    bob = Patron.new("Bob")

    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")

    sally = Patron.new("Sally")

    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal [], @dmns.exhibits_by_attendees
  end

  #####
  def test_it_can_return_a_hash_with_interest_count
    @dmns.add_exhibit("Dead Sea Scrolls", 10)
    @dmns.add_exhibit("Gems and Minerals", 0)
    @dmns.add_exhibit("Imax", 20)

    bob = Patron.new("Bob")

    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")

    sally = Patron.new("Sally")

    sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(bob)
    @dmns.admit(sally)

    expected = { 
                "Dead Sea Scrolls" => 2,
                "Gems and Minerals" => 1
               }

    assert_equal expected, @dmns.interest_count
  end
  #####
end
