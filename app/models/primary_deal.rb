class PrimaryDeal < ApplicationRecord
  belongs_to :area
  belongs_to :deal
  belongs_to :project
end
