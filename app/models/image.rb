class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :map
  validates_size_of :image, maximum: 10.megabytes, message: "Upload should be less than 10MB"
end
