class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    hug = Hug.find(params[:hug_id])
    @review.target = hug.receiver
    @review.reviewer = current_user
    @review.save
    redirect_to hug
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
