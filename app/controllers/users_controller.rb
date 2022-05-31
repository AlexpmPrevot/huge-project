class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @users = User.all

    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
      }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
