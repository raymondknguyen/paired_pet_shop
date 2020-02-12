require 'rails_helper'

RSpec.describe "shelters edit page", type: :feature do
  describe "as a visitor" do
      before(:each) do
        @shelter_1 = Shelter.create(
          name: "Denver Shelter",
          address: "123 fake st.",
          city: "Denver",
          state: "CO",
          zip: "80018"
        )

        @shelter_2 = Shelter.create(
          name: "Aurora Shelter",
          address: "800 Some Ave",
          city: "Aurora",
          state: "CO",
          zip: "80249"
        )
      end

    it "can edit an individual shelter" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Update Shelter')

      click_on "Update Shelter"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

      fill_in :name, with: "Nate's Shelter"
      fill_in :address, with: "123 Bark Plaza"
      fill_in :city, with: "Aurora"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80014

      click_on 'Edit Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("Nate's Shelter")
      expect(page).to_not have_content(@shelter_1.name)
    end

    it "shows a message when i try to update a shelter with incomplete fields" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link('Update Shelter')

      click_on "Update Shelter"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

      #name is missing content
      fill_in :name, with: ""
      fill_in :address, with: "123 Bark Plaza"
      fill_in :city, with: "Aurora"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80014

      click_on 'Edit Shelter'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
      expect(page).to have_content("Name can't be blank")
    end
  end
end
