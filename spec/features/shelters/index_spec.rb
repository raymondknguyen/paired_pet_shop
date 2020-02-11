require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  describe "as a a visitor do"
    before(:each) do
      PetApplication.destroy_all
      Shelter.destroy_all
      Pet.destroy_all
      Application.destroy_all
      @shelter_1 = Shelter.create(
                         name: "Mike's Shelter",
                         address: "1331 17th Street",
                         city: "Denver",
                         state: "CO",
                         zip: 80202
                       )
      @shelter_2 = Shelter.create(
                          name: "Meg's Shelter",
                          address: "150 Main Street",
                          city: "Hershey",
                          state: "PA",
                          zip: 17033
                        )
    end

    it "can see all the shelters avaiable" do
      visit "/shelters"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_link('Create New Shelter')
      expect(page).to have_link('Edit Shelter')
      expect(page).to have_button('Delete Shelter')
  end

  it 'has links to shelters' do
    visit '/shelters'

    expect(page).to have_link("Mike's Shelter")

    click_link(@shelter_1.name)

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    visit '/shelters'

    expect(page).to have_link("Meg's Shelter")

    click_link(@shelter_2.name)

    expect(current_path).to eq("/shelters/#{@shelter_2.id}")
  end
end
