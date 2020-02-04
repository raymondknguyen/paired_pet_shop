require 'rails_helper'

RSpec.describe "shelter new page", type: :feature do
  it "can can create a new shelter" do

    visit "/shelters"
    expect(page).to have_link("Create New Shelter")

    click_on "Create New Shelter"
    expect(current_path).to eq('/shelters/new')

    fill_in :name, with: "Nate's Shelter"
    fill_in :address, with: "123 Fake St."
    fill_in :city, with: "Aurora"
    fill_in :state, with: "CO"
    fill_in :zip, with: 80014

    click_on "Create Shelter"

    expect(current_path).to eq('/shelters')

    new_shelter = Shelter.last

    expect(page).to have_content(new_shelter.name)
  end
end
