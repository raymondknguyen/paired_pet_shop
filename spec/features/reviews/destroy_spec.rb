RSpec.describe 'on shelter show page' do
  before(:each) do
    @shelter_1 = Shelter.create(
      name: "Denver Shelter",
      address: "123 fake st.",
      city: "Denver",
      state: "CO",
      zip: "80018"
    )

    @review = Review.create(
      title: "Awesome Shelter",
      rating: 5,
      content: "They were so helpful!",
      picture: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497",
      shelter: @shelter_1)

    @review_2 = Review.create(
      title: "Good",
      rating: 4,
      content: "Good!",
      shelter: @shelter_1)

  end
  it 'can destroy an indivdual review' do
    visit "/shelters/#{@shelter_1.id}"

    within("#review-#{@review.id}") do

      click_on "Delete Review"

    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to_not have_content("Awesome Shelter")
    expect(page).to_not have_content("They were so helpful!")
  end
end
