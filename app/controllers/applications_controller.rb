class ApplicationsController < ApplicationController
  def new
    pets = Pet.all
    @all_favs = pets.find_all do |pet|
      session[:favorites].find do |favorite|
        pet.id == favorite
      end
    end
  end

  def create
    @application = Application.create(application_params)
    if @application.save
      flash[:success] = "Application Submitted Successfully"
      @application.pets = (
      pets = Pet.all
      @all_favs = pets.find_all do |pet|
        session[:favorites].find do |favorite|
          pet.id == favorite
        end
      end)
      session[:favorites] = []
      redirect_to '/favorites'
    else
      flash[:error] = "Error, Missing Fields"
      redirect_to "/applications/new"
    end
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description_why)
    end
end
