require "rails_helper"

RSpec.describe "On shelter show page" do
  describe "as a visitor" do
    it "can create a new review" do
      shelter_1 = Shelter.create(
        name: "Mike's Shelter",
        address: "1331 17th Street",
        city: "Denver",
        state: "CO",
        zip: 80202
      )
      visit "/shelters/#{shelter_1.id}"

      click_link "Add New Review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

      fill_in :title, with: "Good!"
      fill_in :rating, with: 4
      fill_in :content, with: "Good place to keep your unwanted pets"
      fill_in :picture, with: "https://image.shutterstock.com/image-photo/dog-260nw-587562362.jpg"

      click_on "Submit"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      new_review = Review.last

      expect(new_review.title).to eq("Good!")
      expect(page).to have_content(new_review.title)
    end
  end
end


