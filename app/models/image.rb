class Image < ActiveRecord::Base
  belongs_to :weekend
  validate :image
  validate :weekend_id, presence: true
  mount_uploader :image, ImageUploader
end
