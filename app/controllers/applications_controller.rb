class ApplicationsController < ApplicationController

  def index
    @pet = Pet.find(params[:id])
  end

  def new
    pets = Pet.all
    @all_favs = pets.find_all do |pet|
      session[:favorites].find do |favorite|
        pet.id == favorite
      end
    end
  end

  def create
    application = Application.new(application_params)
    if params[:adopt_pets] != nil
      params[:adopt_pets].each do |pet_id|
        pet = Pet.find(pet_id.to_i)
      pet.applications.create(application_params)
      end
      if application.save
        flash[:success] = "Application Submitted Successfully"
        params[:adopt_pets].each do |pet|
          session[:favorites].delete(pet.to_i)
          pet = Pet.find(pet.to_i)
          pet.update( {adoption_status: "pending"} )
        end
        redirect_to '/favorites'
      end
    else
      flash[:error] = "Error, Missing Fields"
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  def approve_pet
    pet = Pet.find(params[:pet_id])
    applicant = Application.find(params[:application_id])
    pet.update( {adoption_status: "Approved"} )
    flash[:success] = "On hold for #{applicant.name} "
    redirect_to "/pets/#{pet.id}"
  end 

  def unapprove_pet
    pet = Pet.find(params[:pet_id])
    applicant = Application.find(params[:application_id])
    pet.update( {adoption_status: "pending"} )
    redirect_to "/applications/#{applicant.id}"
  end 

  def approve_all
    params[:favorite_pets].each do |pet_id|
      pet = Pet.find(pet_id)
      pet.update( {adoption_status: "Approved"} )
    end
    redirect_to "/shelters"
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description_why)
    end
end
