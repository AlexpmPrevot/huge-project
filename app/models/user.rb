class User < ApplicationRecord
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?
  before_create :set_avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def currently_logged_in(logged_in = true)
    where(logged_in: logged_in).where("last_request_at > ?", Time.zone.now - timeout_in.seconds)
  end

  def currently_logged_in?
    logged_in? && last_request_at.present? && !timedout?(last_request_at)
  end

  def set_avatar
    self.avatar = 'avatars/Cactus1.png'
  end

  def upgrade_avatar
    level = (self.score.round(-2) / 100)
    self.avatar = "avatars/Cactus#{level}.png"
    self.save
  end
end
