require 'rails_helper'

RSpec.describe "pets show page", type: :feature do
  describe "as a visitor" do
    it "can see the attributes for one pet" do
      shelter_1 = Shelter.create!(
        name: "Meg's Shelter",
        address: "150 Main Street",
        city: "Hershey",
        state: "PA",
        zip: 17033
      )
      pet_1 = Pet.create(
        image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
        name: "Sammy",
        description: "Adorable",
        age: 4,
        sex: "Male",
        shelter: shelter_1
      )

      visit "/pets/#{pet_1.id}"

      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(pet_1.adoption_status)

      click_button "Delete Pet"

      expect(current_path).to eq('/pets')
      expect(page).to_not have_css("img[src*='#{pet_1.image}']")
      expect(page).to_not have_content(pet_1.name)
      expect(page).to_not have_content(pet_1.age)
      expect(page).to_not have_content(pet_1.sex)
      expect(page).to_not have_content(pet_1.description)
    end
  end
end
