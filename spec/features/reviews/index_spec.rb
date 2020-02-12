require 'rails_helper'

RSpec.describe "shelter show page", type: :feature do
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

      @review = Review.create(
        title: "Awesome Shelter",
        rating: 5,
        content: "They were so helpful!",
        picture: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497",
        shelter: @shelter_1
      )
      @review_2 = Review.create(
        title: "Good",
        rating: 4,
        content: "Good!",
        shelter: @shelter_2
      )

    end

    it 'can see all the reviews of this shelter' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.rating)
      expect(page).to have_content(@review.content)

      expect(page).to_not have_content(@review_2.title)
      expect(page).to_not have_content(@review_2.rating)
      expect(page).to_not have_content(@review_2.content)
    end
  end
end
