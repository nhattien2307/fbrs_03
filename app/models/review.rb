class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :activities, as: :target

  delegate :name, to: :user, prefix: :user, allow_nil: true
  delegate :title, to: :book, prefix: :book, allow_nil: true
end
