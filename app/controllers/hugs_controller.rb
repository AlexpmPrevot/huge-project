class HugsController < ApplicationController
  def new
    @hug = Hug.new
  end

  def show
    @hug = Hug.find(params[:id])
  end

  def create
    @hug = Hug.new
    @sender_id = current_user.id
    @hug.sender_id = @sender_id
    user = User.find(params[:user_id])
    @hug.receiver_id = user.id
    @hug.progress = 0
    if @hug.save
      HugChannel.broadcast_to(user, "coucou")
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
