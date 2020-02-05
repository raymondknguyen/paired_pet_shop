class Favorite
  attr_reader :pets

  def initialize(pets = [])
    @pets = pets
  end

  def count
    @pets.count
  end
end
