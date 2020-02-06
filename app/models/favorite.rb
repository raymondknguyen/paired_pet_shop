class Favorite
  attr_reader :pets

  def initialize(pets = [])
    @pets = pets
  end

  def count
    @pets.count
  end

  def add_pet(pet)
    @pets << pet.id
  end

  def include_pet?(pet)
    @pets.any? do |selected_pet|
      selected_pet == (pet[:id])
    end
  end
end
