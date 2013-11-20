class Week < ActiveRecord::Base
  has_many :weekends
  validates :date, presence: true
  default_scope -> { order('date DESC') }

end