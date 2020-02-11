require "rails_helper"

  RSpec.describe "on the index page", type: :feature do
    describe "as a visitor" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Denver Shelter",
                                    address: "123 fake st.",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80018")
      end
      it "can delete shelter" do

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_button("Delete Shelter")

      click_on "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter_1.name)
    end

    it "can not delete a shelter if a pet has a pending status" do
      pet_1 = Pet.create(
        image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
        name: "Sammy",
        description: "Adorable",
        age: 4,
        sex: "Male",
        adoption_status: "pending",
        shelter: @shelter_1
      )

      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_button("Delete Shelter")

      click_on "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to have_content(@shelter_1.name)
      expect(page). to have_content("Can not delete shelter with pending pet application")
    end

    it "deletes all reviews when a shelter has been deleted" do
      review_1 = Review.create(title: "Awesome Shelter",
                            rating: 5,
                            content: "They were so helpful!",
                            picture: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497",
                            shelter: @shelter_1
                          )
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_button("Delete Shelter")
      save_and_open_page
      click_on "Delete Shelter"

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter_1.name)
    end
  end
end
