class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :applications
  has_many :applications, through: :pet_applications
  validates_presence_of :image, :name, :description, :age, :sex
end
