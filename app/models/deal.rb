class Deal < ApplicationRecord
  belongs_to :project
  belongs_to :map
  
  has_one :schedule, dependent: :destroy
  has_one :workletter, dependent: :destroy
  
  has_many :areas_deals, :dependent => :destroy
  has_many :areas, through: :areas_deals
  
  has_many :primary_deals, :dependent => :destroy
  
  has_many :dealimages, dependent: :destroy
  accepts_nested_attributes_for :dealimages


  def cost_per_sq_feet
    final_construction_cost.to_f / area_square_feet.to_f
  end

  def remains
    completed = [
      :punchlist_complete, :permit_received, :certificate_of_insurance,
      :certificate_of_occupancy, :final_lien_waver,
      :w9, :construction_cost_summary, :as_builts_received,
      :sprinkler_shop_drawings, :air_balance_report
    ].select {|m| self.send(m).present?}.count
    remains = 10 - completed
    remains
  end

  def status
    if remains == 10
      'not-started'
    elsif remains == 0
      'completed'
    elsif (remains < 10 && remains > 5)
      'begun'
    elsif (remains <= 5 && remains > 0)
      'in-progress'
    end
  end

end
