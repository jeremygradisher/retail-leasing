class Icon < ApplicationRecord
  mount_uploader :icon, IconUploader
  belongs_to :project
  validates_size_of :icon, maximum: 2.megabytes, message: "Upload should be less than 2MB"
end
