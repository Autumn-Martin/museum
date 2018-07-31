require "./lib/patron"

class Museum
  attr_reader :name, :exhibits, :patrons
  def initialize(name)
    @name = name
    @exhibits = []
    @revenue = 0
    @patrons = []
  end

  def build_exhibit(name, price)
    { name => price}
  end

  def add_exhibit(name, price)
    exhibit = build_exhibit(name, price)

    @exhibits << exhibit
  end

  def admit(patron)
    @patrons << patron
  end

  # sum of the costs of the exhibits that people like
  # people
  # exhibits people like
  # sum the price of those exhibits

  def revenue
    interests_to_costs.sum
  end

  def interests_to_costs
    interests = get_interests
    interests.map do |interest|
      get_exhibit_costs(interest)
    end.flatten
  end

  def get_exhibit_costs(interest)
    exhibits.map do |exhibit|
      exhibit[interest]
    end.compact
  end

  def get_interests
    @patrons.map do |patron|
      patron.interests
    end.flatten
  end

  def patrons_interested_in_exhibit(exhibit)
    @patrons.find_all do |patron|
      patron.interests.include?(exhibit)
    end
  end

  def patrons_of(exhibit)
    patrons_interested_in_exhibit(exhibit).map do |patron|
      patron.name
    end
  end

  def interest_count
    count_hash = {}
    get_interests.each do |interest|
      if count_hash[interest]
        count_hash[interest] += 1
      else
        count_hash[interest] = 1
      end
    end
    count_hash
  end

  def exhibits_by_attendees
    # patrons
    # interests for patrons
    # currently have array of strings
    # iterate over interests
    # want to return an array of hashes

    # find a exhibit where the key is the interest
    interests = get_interests
    interests.map do |interest|
      get_exhibit_for_interest(interest)
    end
  end

  def get_exhibit_for_interest(interest)
    # interest = "interest"
    @exhibits.find do |exhibit|
      !exhibit[interest].nil?
    end
  end

end
