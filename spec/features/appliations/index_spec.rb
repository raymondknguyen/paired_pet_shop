require 'rails_helper'

RSpec.describe "applying for a pet index" do
  it 'lets me apply for a pet that i have favorited' do
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

    visit '/favorites'

    click_on "Adpot My Favorite Pets"

    expect(current_path).to eq('/favorites/application/new')

    fill_in :name, with: "Nathan Keller"
    fill_in :address, with: "1234 Main St"
    fill_in :city, with: "Arvada"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80003
    fill_in :phone_number, with: "303-725-6266"
    fill_in :description, with: "I LOVE DOGS"

    click_on "Submit Application"

    expect(page).to have_content("Application Submitted Successfully")
    expect(current_path).to eq.("/favorites")
    expect(page).to have_content("You have no pets favorited!")
  end
end