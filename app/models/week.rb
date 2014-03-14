class Week < ActiveRecord::Base
  has_many :weekends
  validates :date, presence: true
  default_scope -> { order('date DESC') }
  self.per_page = 2

  def next
    self.class.where("date <= ? AND id != ?", date, id).first
  end 

  def previous
    self.class.where("date >= ? AND id != ?", date, id).first
  end 
end