class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.create(review_params)
    if review.save
      flash[:success] = "Thanks for the Review"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = "#{shelter.name} review not created. Missing Field"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:shelter_id])
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save
      flash[:success] = "Thanks for updating your review"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = "#{shelter.name} review not updated. Missing Field"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
