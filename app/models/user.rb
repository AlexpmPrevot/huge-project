class User < ApplicationRecord
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
