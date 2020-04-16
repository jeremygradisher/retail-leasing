class AreasDeal < ApplicationRecord
  belongs_to :project
  belongs_to :area
  belongs_to :deal
end
