require 'rails_helper'

RSpec.describe "pets show page", type: :feature do
  before do
    @shelter_1 = Shelter.create!(
      name: "Meg's Shelter",
      address: "150 Main Street",
      city: "Hershey",
      state: "PA",
      zip: 17033
    )
    @pet_1 = Pet.create(
      image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
      name: "Sammy",
      description: "Adorable",
      age: 4,
      sex: "Male",
      shelter: @shelter_1
    )
    @ray = @pet_1.applications.create!(name: "Ray Nguyen",
            address: "123 Fake st.",
            city: "Denver",
            state: "Colorado",
            zip: "80230",
            phone_number: "1234567890",
            description_why: "Because why not")
    @ray = @pet_1.applications.create!(name: "Billy",
            address: "800 Fakest Ave.",
            city: "Denver",
            state: "Colorado",
            zip: "80230",
            phone_number: "1234567890",
            description_why: "Because why not")
    
  end
  it "can see the attributes for one pet" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_css("img[src*='#{@pet_1.image}']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.description)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.adoption_status)
    expect(page).to have_button("Delete Pet")
    expect(page).to have_button("Favorite Pet")
  end

  it "can favorite a pet" do
    visit "/pets/#{@pet_1.id}"

    click_on("Favorite Pet")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been added to your favorites!")
    expect(page).to have_content('(1) Favorited Pets')
  end

  it "can redirect to favorites" do
    visit "/pets/#{@pet_1.id}"
    click_on "Favorite Pet"

    visit "/favorites"

    click_button "Remove Pet From Favorites"

    expect(current_path).to eq("/favorites")

    expect(page).to have_content("(0) Favorited Pets")
  end
  
  it "can see a list of all the names of the applicants for this pet" do
    visit "/pets/#{@pet_1.id}"

    click_link "View All Applications"

    expect(page).to have_link("Billy")
    expect(page).to have_link("Ray Nguyen")

    click_on "Billy"

    expect(current_path).to eq("/applications/#{@ray.id}")
  end
end
