class Mark < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum status: {read: 0, favorite: 1, reading: 2}
end
