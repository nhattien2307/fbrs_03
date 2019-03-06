class Category < ApplicationRecord
  validates :name, presence: true, length: {minimum: Settings.category.name.min}

  has_many :books, dependent: :destroy
end
