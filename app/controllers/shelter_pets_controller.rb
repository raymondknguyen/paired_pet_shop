class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex)
    end
end
