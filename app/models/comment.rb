class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  delegate :name, to: :user, prefix: :user, allow_nil: true
end
