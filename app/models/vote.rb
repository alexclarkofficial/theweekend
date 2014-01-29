class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekend, counter_cache: true
  validates :user_id, presence: true, uniqueness: {scope: :weekend_id}
  validates :weekend_id, presence: true
end