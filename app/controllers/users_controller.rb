class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    current_user.set_avatar if current_user
    @users = User.all
    @users.each do |user|
      user.upgrade_avatar
    end

    @markers = @users.geocoded.map do |user|
      {
        id: user.id,
        lat: user.latitude,
        lng: user.longitude,
        image_url: helpers.asset_url("https://us.123rf.com/450wm/sudowoodo/sudowoodo1611/sudowoodo161100017/67676118-hug-cactus-de-dessin-vectoriel-couple-cactus-mignon-de-bande-dessin%C3%A9e-dans-l-amour-illustration-dr%C3%B4l.jpg"),
        info_window: render_to_string(partial: "users/info_window", locals: { user: user }, formats: [:html]),
        logged_in: user.logged_in
      }
    end

    if current_user && current_user.latitude && current_user.longitude
      @users = @users.geocoded.sort_by do |user|
        current_user.distance_to([user.longitude, user.latitude])
      end.reverse
    end
    respond_to do |format|
      format.html {}
      format.json { render json: @markers.as_json }
    end
  end

  def show
    @user = User.find(params[:id])

    @user.upgrade_avatar
    @review = Review.new
    @reviews = Review.all.where(id: [@receiver_id, @sender_id])
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
