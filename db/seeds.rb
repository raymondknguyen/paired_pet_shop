# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
PetApplication.destroy_all
Shelter.destroy_all
Review.destroy_all
Pet.destroy_all
shelter_1 = Shelter.create(
  name: "Mike's Shelter",
  address: "1331 17th Street",
  city: "Denver",
  state: "CO",
  zip: 80202
)

shelter_2 = Shelter.create(
  name: "Meg's Shelter",
  address: "150 Main Street",
  city: "Hershey",
  state: "PA",
  zip: 17033
)

Pet.create!(
  image: "https://image.shutterstock.com/image-photo/playing-dogs-garden-260nw-1556131820.jpg",
  name: "Fido",
  description: "Silly",
  age: 2,
  sex: "Female",
  adoption_status: "open",
  shelter: shelter_1
)
Pet.create!(
  image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2019/09/Dogs-portrait-3.jpg?w=750",
  name: "Nelly",
  description: "Butthead",
  age: 3,
  sex: "Male",
  adoption_status: "open",
  shelter: shelter_1
)

Pet.create!(
  image: "https://image.shutterstock.com/image-photo/dog-headshot-on-yellow-background-260nw-324936848.jpg",
  name: "Sammy",
  description: "Weird",
  age: 4,
  sex: "Male",
  adoption_status: "pending",
  shelter: shelter_2
)
lucii = Pet.create!(
  image: "https://static.boredpanda.com/blog/wp-content/uploads/2020/01/funny-dog-teeth-toofers-3-5e255a95cd31e__700.jpg",
  name: "Lucii",
  description: "Cute",
  age: 4,
  sex: "Male",
  adoption_status: "pending",
  shelter: shelter_2
)
amel = Pet.create!(
  image: "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__340.jpg",
  name: "Amel",
  description: "Playful",
  age: 4,
  sex: "Male",
  adoption_status: "pending",
  shelter: shelter_2
)
homer = Pet.create!(
  image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2018/01/12201051/cute-puppy-body-image.jpg",
  name: "Homer",
  description: "Inhuman",
  age: 4,
  sex: "Male",
  adoption_status: "pending",
  shelter: shelter_2
)

ray = Application.create(name: "Ray Nguyen",
            address: "123 Fake st.",
            city: "Denver",
            state: "Colorado",
            zip: "80230",
            phone_number: "1234567890",
            description_why: "Because why not")

PetApplication.create(pet: lucii, application: ray)
PetApplication.create(pet: amel, application: ray)
PetApplication.create(pet: homer, application: ray)




review_1 = Review.create(title: "Awesome Shelter",
                      rating: 5,
                      content: "They were so helpful!",
                      picture: "https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497",
                      shelter: shelter_1
                    )
