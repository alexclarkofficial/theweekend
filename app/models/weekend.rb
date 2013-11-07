class Weekend < ActiveRecord::Base
  belongs_to :user
  belongs_to :week
  has_many :votes, dependent: :destroy
  default_scope -> { order('week_id DESC') }
  validates :week_id, presence: true
  validates :user_id, presence: true
  has_many :voters, through: :votes, source: :user

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
    	  user_id: user)
  end
end