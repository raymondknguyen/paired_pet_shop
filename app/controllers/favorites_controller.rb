class FavoritesController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    # require "pry"; binding.pry

    if favorites.pets == []
      favorites.add_pet(pet)
      flash[:success] = "#{pet.name} has been added to your favorites!"
    elsif favorites.pets.last["id"] == pet.id
      flash[:error] = "#{pet.name} Already Added to Favorites"
    else
      favorites.add_pet(pet)
      flash[:success] = "#{pet.name} has been added to your favorites!"
    end
    redirect_to "/pets/#{pet.id}"
  end



end
