class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :target ,polymorphic: true
  scope :by_user,
    ->(user_id){where user_id: user_id}
  scope :newest, ->{order created_at: :DESC}
  delegate :name, to: :user, prefix: :user, allow_nil: true
end
