class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @users = User.all


    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        image_url: helpers.asset_url("https://picsum.photos/1000/1000"),
        info_window: render_to_string(partial: "users/info_window", locals: { user: user }, formats: [:html]),
        logged_in: user.logged_in
      }
    end
    respond_to do |format|
      format.html {}
      format.json { render json: @markers.as_json }
    end
  end

  def show
    @user = User.find(params[:id])
    @review = Review.new
  end

  def set_geoloc
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:latitude, :longitude)
  end
end
