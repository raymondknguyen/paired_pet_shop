require 'rails_helper'

RSpec.describe "applying for a pet" do
  before :each do
    PetApplication.destroy_all
    Shelter.destroy_all
    Pet.destroy_all
    Application.destroy_all
  end

  it 'lets me apply for a pet that I have favorited' do
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
    visit "/pets/#{pet_1.id}"
    click_on "Favorite Pet"

    visit '/favorites'

    click_on "Adopt My Favorite Pets"

    expect(current_path).to eq('/applications/new')

    within "#favorite-#{pet_1.id}" do
      check "adopt_pets[]"
    end


    fill_in :name, with: "Nathan Keller"
    fill_in :address, with: "1234 Main St"
    fill_in :city, with: "Arvada"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80003
    fill_in :phone_number, with: "303-725-6266"
    fill_in :description_why, with: "I LOVE DOGS"

    click_on "Submit Application"

    expect(page).to have_content("Application Submitted Successfully")
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("You have no pets favorited!")
  end

  it 'errors if the application is incomplete' do
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

    click_on "Adopt My Favorite Pets"

    expect(current_path).to eq('/applications/new')

    #not filling in a name
    fill_in :address, with: "1234 Main St"
    fill_in :city, with: "Arvada"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80003
    fill_in :phone_number, with: "303-725-6266"
    fill_in :description_why, with: "I LOVE DOGS"

    click_on "Submit Application"

    expect(page).to have_content("Error, Missing Fields")
    expect(current_path).to eq("/applications/new")
  end
end
