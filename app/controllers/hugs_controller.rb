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
        user_id: user.id,
        lat: user.latitude,
        lng: user.longitude,
        image_url: helpers.asset_url("#{user.avatar}"),
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
    @hug.progress = :pending
    if @hug.save
      HugChannel.broadcast_to(user, render_to_string(partial: "hug_modal", locals: { hug: @hug }))
      redirect_to user_path(user), notice: "Hug send successfuly"
    else
      render 'new'
    end
  end

  def update
    @hug = Hug.find(params[:id])
    @hug.accepted!
    HugChannel.broadcast_to(@hug.sender, render_to_string(partial: "accept_hug_modal", locals: { hug: @hug }))
    redirect_to @hug
  end

  def destroy
    @hug = Hug.find(params[:id])
    redirect_to users_path if @hug.destroy
  end

  private

  def hug_params
    params.require(:hug).permit(:progress, :receiver_id, :sender_id)
  end
end
