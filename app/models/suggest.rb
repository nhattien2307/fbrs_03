class Suggest < ApplicationRecord
  belongs_to :user
  validates :name_book, presence: true

  scope :newest, ->{order created_at: :DESC}
  scope :by_user,
    ->(user_ids){where user_id: user_ids if user_ids.present?}

  enum status: {waiting: 0, rejected: 1, accepted: 2}
  delegate :name, to: :user, prefix: :user, allow_nil: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |suggest|
        csv << suggest.attributes.values_at(*column_names)
      end
    end
  end
end
