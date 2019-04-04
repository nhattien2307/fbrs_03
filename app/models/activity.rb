class Activity < PublicActivity::Activity
  scope :newest, ->{order created_at: :DESC}
  scope :user_following, ->(ids){where owner_id: ids}
end
