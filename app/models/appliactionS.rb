class Appliactions < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validate_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
end
