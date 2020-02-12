require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  it "can count the number of pets in a shelter" do
    shelter_1 = Shelter.create(
      name: "Denver Shelter",
      address: "123 fake st.",
      city: "Denver",
      state: "CO",
      zip: "80018"
    )

    pet_3 = Pet.create(
      image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
      name: "Sammy",
      description: "Adorable",
      age: 4,
      sex: "Male",
      adoption_status: "approved",
      shelter: shelter_1
    )

    pet_2 = Pet.create!(
      image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/09/Dogs-portrait-3.jpg?w=750",
      name: "Nelly",
      description: "butthead",
      age: 3,
      sex: "Male",
      adoption_status: "open",
      shelter: shelter_1)

      expect(shelter_1.pet_count).to eq(2)
  end

  it "can provide an average review rating" do
    shelter_1 = Shelter.create(
      name: "Denver Shelter",
      address: "123 fake st.",
      city: "Denver",
      state: "CO",
      zip: "80018"
    )

    review_1 = Review.create(
      title: "Awesome Shelter",
      rating: 5,
      content: "They were so helpful!",
      picture: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497",
      shelter: shelter_1
    )

    review_2 = Review.create(
      title: "Bad",
      rating: 1,
      content: "So bad",
      shelter: shelter_1
    )

      expect(shelter_1.average_rating).to eq(3)
  end

  it "can count the applciations for pets for the shelter" do
    shelter_1 = Shelter.create(
      name: "Denver Shelter",
      address: "123 fake st.",
      city: "Denver",
      state: "CO",
      zip: "80018"
    )

    pet_3 = Pet.create(
      image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
      name: "Sammy",
      description: "Adorable",
      age: 4,
      sex: "Male",
      adoption_status: "approved",
      shelter: shelter_1
    )

    pet_2 = Pet.create!(
      image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/09/Dogs-portrait-3.jpg?w=750",
      name: "Nelly",
      description: "butthead",
      age: 3,
      sex: "Male",
      adoption_status: "open",
      shelter: shelter_1)

    pet_2.applications.create!(
      name: "Ray Nguyen",
      address: "123 Fake st.",
      city: "Denver",
      state: "Colorado",
      zip: "80230",
      phone_number: "1234567890",
      description_why: "Because why not"
    )

    pet_2.applications.create!(
      name: "Nathan",
      address: "456 Main St",
      city: "Arvada",
      state: "Colorado",
      zip: "80003",
      phone_number: "267385900",
      description_why: "Because dogs are awesome"
    )

    expect(shelter_1.application_count).to eq(2)
  end
end
