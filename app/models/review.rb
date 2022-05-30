class Review < ApplicationRecord
  belongs_to :target
  belongs_to :reviewer
  belongs_to :hug
end
