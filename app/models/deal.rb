class Deal < ApplicationRecord
  belongs_to :project
  belongs_to :map
end
