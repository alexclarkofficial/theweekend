class Weekend < ActiveRecord::Base
  belongs_to :user
  has_many :votes, dependent: :destroy
  default_scope -> { order('week DESC') }
  validates :week, presence: true
  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
    	  user_id: user)
  end
end