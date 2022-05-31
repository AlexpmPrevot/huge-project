class User < ApplicationRecord
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def currently_logged_in(logged_in = true)
    where(logged_in: logged_in).where("last_request_at > ?", Time.zone.now - timeout_in.seconds)
  end

  def currently_logged_in?
    logged_in? && last_request_at.present? && !timedout?(last_request_at)
  end
end
