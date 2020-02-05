class Favorite
  attr_reader :pets

  def initialize(pets = [])
    @pets = pets
  end

  def count
    @pets.count
  end

  def add_pet(pet)
    @pets << pet
  end

  def includes_pet?(pet)

  end
end
