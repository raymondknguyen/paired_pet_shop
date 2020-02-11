require 'rails_helper'

RSpec.describe "application show page", type: :feature do
  describe "as a visitor" do
    before do
      @shelter_2 = Shelter.create!(
        name: "Meg's Shelter",
        address: "150 Main Street",
        city: "Hershey",
        state: "PA",
        zip: "17033"
      )
      @pet_1 = Pet.create!(
        image: "https://image.shutterstock.com/image-photo/playing-dogs-garden-260nw-1556131820.jpg",
        name: "Fido",
        description: "Silly",
        age: 2,
        sex: "Female",
        adoption_status: "pending",
        shelter: @shelter_2
      )
      @pet_2 = Pet.create!(
        image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/09/Dogs-portrait-3.jpg?w=750",
        name: "Nelly",
        description: "butthead",
        age: 3,
        sex: "Male",
        adoption_status: "pending",
        shelter: @shelter_2
      )
      @pet_3 = Pet.create!(
        image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
        name: "Sammy",
        description: "Adorable",
        age: 4,
        sex: "Male",
        adoption_status: "open",
        shelter: @shelter_2
      )
      @ray = @pet_1.applications.create!(name: "Ray Nguyen",
            address: "123 Fake st.",
            city: "Denver",
            state: "Colorado",
            zip: "80230",
            phone_number: "1234567890",
            description_why: "Because why not")
    
    end

    it "sees application and its information" do

      visit "/applications/#{@ray.id}"

      expect(page).to have_content(@ray.name)
      expect(page).to have_content(@ray.address)
      expect(page).to have_content(@ray.city)
      expect(page).to have_content(@ray.state)
      expect(page).to have_content(@ray.zip)
      expect(page).to have_content(@ray.phone_number)
      expect(page).to have_content(@ray.description_why)
      expect(page).to have_link(@pet_1.name)

      click_link @pet_1.name

      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end

    it 'it can approve the application for that pet' do

        visit "/applications/#{@ray.id}"

        expect(page).to have_content("#{@pet_1.name}")

        click_on 'Approve'

        expect(current_path).to eq("/pets/#{@pet_1.id}")
        @pet_1.reload
        expect(@pet_1.adoption_status).to eq("Approved")
        expect(page).to have_content("On hold for #{@ray.name}")
    end
  end
end


