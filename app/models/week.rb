class Week < ActiveRecord::Base
  has_many :weekends
  validates :date, presence: true
  default_scope -> { order('date DESC') }
  self.per_page = 2
end