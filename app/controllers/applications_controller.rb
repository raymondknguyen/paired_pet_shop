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
    application = Application.new(application_params)
    if params[:adopt_pets] != nil
      params[:adopt_pets].each do |pet_id|
        x = Pet.find(pet_id.to_i)
        x.applications.create(application_params)
      end
      if application.save
        flash[:success] = "Application Submitted Successfully"
        params[:adopt_pets].each do |pet|
          session[:favorites].delete(pet.to_i)
          y = Pet.find(pet.to_i)
          y.update( {adoption_status: "pending"} )
        end
        redirect_to '/favorites'
      end
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
