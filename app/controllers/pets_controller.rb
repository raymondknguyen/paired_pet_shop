class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    if pet.save
      redirect_to "/pets/#{pet.id}"
    else
      flash[:error] = "#{pet.errors.full_messages.to_sentence}"
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    if session[:favorites] != nil && session[:favorites].length >= 1
      pet = Pet.find(params[:id])
      session[:favorites].delete(pet.id)
    end
    Pet.destroy(params[:id])

    redirect_to '/pets'
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.new(pet_params)

    if pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:error] = "#{pet.errors.full_messages.to_sentence}"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex)
    end

    def required_params
      params.permit(:name, :description, :age, :sex)
    end
end
