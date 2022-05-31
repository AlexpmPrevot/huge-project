class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @users = User.all

    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        image_url: helpers.asset_url("https://picsum.photos/1000/1000"),
        info_window: render_to_string(partial: "info_window", locals: { user: user })
      }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
