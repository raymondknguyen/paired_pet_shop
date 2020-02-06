require 'rails_helper'
RSpec.describe "favorites index page", type: :feature do
    before do
      @shelter_2 = Shelter.create!(
        name: "Meg's Shelter",
        address: "150 Main Street",
        city: "Hershey",
        state: "PA",
        zip: 17033
      )
      @pet_1 = Pet.create(
        image: "https://image.shutterstock.com/image-photo/playing-dogs-garden-260nw-1556131820.jpg",
        name: "Fido",
        description: "Silly",
        age: 2,
        sex: "Female",
        shelter: @shelter_2
      )
      @pet_2 = Pet.create(
        image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/09/Dogs-portrait-3.jpg?w=750",
        name: "Nelly",
        description: "butthead",
        age: 3,
        sex: "Male",
        shelter: @shelter_2
      )
      @pet_3 = Pet.create(
        image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
        name: "Sammy",
        description: "Adorable",
        age: 4,
        sex: "Male",
        shelter: @shelter_2
      )
    end
    it "can see favorited pets" do
      visit "/pets/#{@pet_1.id}"
      click_on "Favorite Pet"
      visit "/pets/#{@pet_2.id}"
      click_on "Favorite Pet"
      visit "/pets/#{@pet_3.id}"
      click_on "Favorite Pet"
      visit '/favorites'
      expect(page).to have_link("#{@pet_1.name}")
      expect(page).to have_css("img[src*='#{@pet_1.image}']")
      expect(page).to have_link("#{@pet_2.name}")
      expect(page).to have_css("img[src*='#{@pet_2.image}']")
      expect(page).to have_link("#{@pet_3.name}")
      expect(page).to have_css("img[src*='#{@pet_3.image}']")
  end
end