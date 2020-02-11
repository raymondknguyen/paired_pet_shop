#app/controllers/shelters_controllers

class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)

    if shelter.save
      redirect_to "/shelters"
    else
      flash[:error] = "#{shelter.errors.full_messages.to_sentence}"
      redirect_to "/shelters/#{shelter.id}/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)

    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = "#{shelter.errors.full_messages.to_sentence}"
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets.any? do |pet|
      pet.adoption_status = "pending"
    end
      flash[:error] = "Can not delete shelter with pending pet application"
    else
      shelter.destroy
    end

    redirect_to '/shelters'
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
