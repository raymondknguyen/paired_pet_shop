#app/models/shelter.rb
class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip

  def pet_count
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    Application
    .joins(pets: [:shelter])
    .where('shelters.id = ?', self.id)
    .count('applications.id')
  end
end
