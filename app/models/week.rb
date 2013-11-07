class Week < ActiveRecord::Base
  has_many :weekends
  validates :date, presence: true
end
