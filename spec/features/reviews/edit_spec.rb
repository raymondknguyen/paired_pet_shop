require 'rails_helper'

RSpec.describe 'on shelter show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Denver Shelter",
                                address: "123 fake st.",
                                city: "Denver",
                                state: "CO",
                                zip: "80018")

    @review = Review.create(title: "Awesome Shelter",
                            rating: 5,
                            content: "They were so helpful!",
                            picture: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497",
                            shelter: @shelter_1)
    @review_2 = Review.create(title: "Good",
                            rating: 4,
                            content: "Good!",
                            shelter: @shelter_1)

  end
  it 'can edit an indivdual review' do
    visit "/shelters/#{@shelter_1.id}"

    within("#review-#{@review.id}") do

      click_on "Edit Review"

    end
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit")

    fill_in :title, with: "Hated Them"
    fill_in :rating, with: 1
    fill_in :content, with: "My dog was sick"
    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_content("Hated Them")
    expect(page).to have_content("My dog was sick")
    expect(page).to_not have_content("Awesome Shelter")
    expect(page).to_not have_content("They were so helpful!")
  end
  it 'cant update review missing field' do
    visit "/shelters/#{@shelter_1.id}"

    within("#review-#{@review.id}") do

      click_on "Edit Review"

    end
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit")

    fill_in :title, with: ""
    fill_in :rating, with: 1
    fill_in :content, with: "My dog was sick"
    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit")
    expect(page).to have_content("#{@shelter_1.name} review not updated. Missing Field")
  end
end
