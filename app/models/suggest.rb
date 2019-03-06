class Suggest < ApplicationRecord
  belongs_to :user
  validates :book_name, presence: true
end
