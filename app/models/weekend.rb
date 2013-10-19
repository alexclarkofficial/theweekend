class Weekend < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :week, presence: true
  validates :user_id, presence: true
end