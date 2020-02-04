require 'rails_helper'

RSpec.describe "shelter show page", type: :feature do
  describe "as a visitor" do
    before(:each) do
      @shelter_1 = Shelter.create(name: "Denver Shelter",
                                  address: "123 fake st.",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80018")

      @shelter_2 = Shelter.create(name: "Aurora Shelter",
                                  address: "800 Some Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80249")
    end

  it "can see the attributes of one shelter" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
    expect(page).to have_link("Update Shelter")
    click_button "Delete Shelter"

    expect(page).to_not have_content(@shelter_2.address)
  end

    it 'can see all the reviews of the shelter' do
      expect(page).to have_content(@shelter_1.reviews.title)
      expect(page).to have_content(@shelter_1.reviews.rating)
      expect(page).to have_content(@shelter_1.reviews.content)
    end
  end
end
