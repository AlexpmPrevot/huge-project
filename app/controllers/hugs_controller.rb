class HugsController < ApplicationController
  def new
    @hug = Hug.new
  end

  def show
    @hug = Hug.find(params[:id])

    @review = Review.new
    @users = User.all.where(id: [@hug.receiver_id, @hug.sender_id])

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

  def create
    @hug = Hug.new
    @sender_id = current_user.id
    @hug.sender_id = @sender_id
    user = User.find(params[:user_id])
    @hug.receiver_id = user.id
    @hug.progress = 0
    if @hug.save
      HugChannel.broadcast_to(user, "test")
      redirect_to user_path(user)
    else
      render 'new'
    end
  end

  def update
    @hug = Hug.find(params[:id])
    @hug.update(hug_params)
    redirect_to @hug
  end

  private

  def hug_params
    params.require(:hug).permit(:progress, :receiver_id, :sender_id)
  end
end
