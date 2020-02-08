class ApplicationsController < ApplicationController
  def new
    pets = Pet.all
    matches = pets.find_all do |pet|
      session[:favorites].find do |favorite|
        pet.id == favorite
      end
    end
    @all_favs = matches.map do |fav|
      fav.name
    end
  end

  def create
    Application.create(application_params)
    flash[:success] = "Application Submitted Successfully"
    session[:favorites] = []
    redirect_to '/favorites'
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description_why)
    end
end
