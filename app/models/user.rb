class User < ApplicationRecord
  geocoded_by :city
  after_create :geocode

  after_create :set_latlong
  has_many :reviews, class_name: "Review", foreign_key: :reviewer_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def currently_logged_in(logged_in = true)
    where(logged_in: logged_in).where("last_request_at > ?", Time.zone.now - timeout_in.seconds)
  end

  def currently_logged_in?
    logged_in? && last_request_at.present? && !timedout?(last_request_at)
  end

  def set_avatar
    if score < 100
      self.avatar = "avatars/Cactus1.png"
    elsif score >= 900
      self.avatar = "avatars/Cactus10.png"
    else
      self.avatar = "avatars/Cactus#{(score / 100).floor + 1}.png" unless score > 100 || score < 900
    end
    self.save
  end

  def upgrade_avatar
    if score < 100
      self.avatar = "avatars/Cactus1.png"
    elsif score >= 900
      self.avatar = "avatars/Cactus10.png"
    else
      level = (score.round(-2) / 100)
      self.avatar = "avatars/Cactus#{level}.png"
      save
    end
  end

  def set_latlong
    results = self.geocode
    self.latitude = results[0]
    self.longitude = results[1]
    self.save

  end
end
