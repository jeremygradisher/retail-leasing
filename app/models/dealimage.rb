class Dealimage < ApplicationRecord
  mount_uploader :dealimage, DealimageUploader
  belongs_to :deal
  validates_size_of :dealimage, maximum: 1.megabytes, message: "Upload should be less than 1MB"
end
