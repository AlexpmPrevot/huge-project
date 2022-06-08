class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar_color, :biography, :city])
  end
end
