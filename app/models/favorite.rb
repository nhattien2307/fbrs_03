class Favorite < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  belongs_to :book
end
