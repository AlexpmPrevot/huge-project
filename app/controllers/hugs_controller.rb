class HugsController < ApplicationController
  def new
    @hug = Hug.new
  end

  def show
    @hug = Hug.find(params[:id])
  end

  def create
    @hug = Hug.new(hug_params)
    if @hug.save
      redirect_to @hug
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
