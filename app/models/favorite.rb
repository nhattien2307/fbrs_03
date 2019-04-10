class Favorite < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  belongs_to :book

  delegate :title, to: :book, prefix: :book, allow_nil: true
end
