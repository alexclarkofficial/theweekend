class Weekend < ActiveRecord::Base
  belongs_to :user
  belongs_to :week
  has_many :votes, dependent: :destroy
  validates :week_id, presence: true
  validates :user_id, presence: true
  has_many :voters, through: :votes, source: :user
  has_many :images
  default_scope -> { order 'votes_count DESC' }
  scope :newest, -> { order 'created_at'}
  accepts_nested_attributes_for :images
  self.per_page = 2

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        user_id: user)
  end

  def self.from_week(week)
    where week_id: week.id
  end

end