class Hug < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :receiver, class_name: "User", foreign_key: :receiver_id
  enum progress: { pending: 0, accepted: 10, denied: 20 }
end
