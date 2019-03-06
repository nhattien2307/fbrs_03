class Book < ApplicationRecord
  belongs_to :category
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.book.title_max},
    uniqueness: {case_sensitive: false}
  validates :author, presence: true, length: {maximum: Settings.book.author_max}
end
