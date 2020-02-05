class FavoritesController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    if favorites.pets.include?(pet.id)
      flash[:error] = "#{pet.name} Already Added to Favorites"
    else
      favorites.add_pet(pet)
      flash[:success] = "#{pet.name} has been added to your favorites!"
    end
    redirect_to "/pets/#{pet.id}"
  end



end
