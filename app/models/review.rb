class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  delegate :name, to: :user, prefix: :user, allow_nil: true
end
