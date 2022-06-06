class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    hug = Hug.find(params[:hug_id])
    @review.hug = hug
    @review.reviewer = current_user
    if current_user == hug.sender
      @review.target = hug.receiver
    else
      @review.target = hug.sender
    end
    @review.save
    redirect_to hug
  end

  private

  def review_params
    params.require(:review).permit(:rating)
  end
end
