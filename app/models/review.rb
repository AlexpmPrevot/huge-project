class Review < ApplicationRecord
  belongs_to :target, class_name: "User", foreign_key: :target_id
  belongs_to :reviewer, class_name: "User", foreign_key: :reviewer_id
  belongs_to :hug
end
