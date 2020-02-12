require "rails_helper"

RSpec.describe Favorite do
  describe "total favorites" do
    it "can calculate the total of pets in favorites" do
      shelter_1 = Shelter.create!(
        name: "Mike's Shelter",
        address: "1331 17th Street",
        city: "Denver",
        state: "CO",
        zip: 80202
      )
      pet_1 = Pet.create(
        image: "https://image.shutterstock.com/image-photo/playing-dogs-garden-260nw-1556131820.jpg",
        name: "Fido",
        description: "Silly",
        age: 2,
        sex: "Female",
        shelter: shelter_1
      )
      pet_2 = Pet.create(
        image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/09/Dogs-portrait-3.jpg?w=750",
        name: "Nelly",
        description: "butthead",
        age: 3,
        sex: "Male",
        shelter: shelter_1
      )
      favorites = Favorite.new([pet_1,pet_2])

      expect(favorites.count).to eq(2)
    end
  end
end
