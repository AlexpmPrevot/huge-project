class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authenticate_user!(opts = {})
    super(opts)

    if current_user
      last_request_at = user_session["last_request_at"]

      if last_request_at.is_a? Integer
        last_request_at = Time.at(last_request_at).utc
      elsif last_request_at.is_a? String
        last_request_at = Time.parse(last_request_at)
      end
      # don't run the validations
      current_user.update_attribute(:last_request_at, last_request_at) # avoid validations
    end
  end
end
