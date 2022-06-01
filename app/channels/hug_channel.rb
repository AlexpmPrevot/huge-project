class HugChannel < ApplicationCable::Channel

  def subscribed
    hug = Hug.find(params[:id])
    stream_for hug
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
