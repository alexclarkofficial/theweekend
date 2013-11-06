class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekend
  validates :user_id, presence: true, uniqueness: {scope: :weekend_id}
  validates :weekend_id, presence: true
end