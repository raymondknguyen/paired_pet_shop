class FavoritesController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    if favorites.pets == []
      favorites.add_pet(pet)
      flash[:success] = "#{pet.name} has been added to your favorites!"
    else
      favorites.add_pet(pet)
      flash[:success] = "#{pet.name} has been added to your favorites!"
    end
    redirect_to "/pets/#{pet.id}"
  end

  def index
    @pets = favorites.pets.map do |pet_id|
      Pet.find(pet_id)
    end
    @all_pet = Pet.all
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorites].delete(pet.id)
    flash[:success] = "#{pet.name} has been removed from your favorites :("
    redirect_back(fallback_location: "/favorites")
  end

  def remove_all
    session[:favorites] = []
    redirect_to '/favorites'
  end
end
