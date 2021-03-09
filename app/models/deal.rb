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

  def self.lease_status_color
    {
      'Available': 'd13e27',
      'Prospect': 'e5ba21',
      'LOI': 'f16528',
      'At Lease': '15958A',
      'Leased': '8bc53f'
    }
  end
  
#  def self.opening_status_color
#    {
#      'No': 'D13E27',
#      'Challenged': 'E5BA21',
#      'Yes': '8BC53F'
#    }
#  end

  def self.owner_approval_color
    {
      false: 'FFFFFF',
      true: '8BC53F'
    }
  end
  
  def self.priority_color
    {
      false: 'FFFFFF',
      true: '8BC53F'
    }
  end

  def self.merchandising_status_color
    {
      'Footwear': '388b00',
      'Auto / Gas': '66635f',
      'Candy / Confectionary': 'f9ef7b',
      'Department Store': 'fed389',
      'Electronics': 'be8b67',
      'Entertainment': 'e62536',
      'Fashion': '67a5d7',
      'Food & Beverage': 'f7b131',
      'Grocery / Hypermarket': 'b6cf42',
      'Home / Furnishings': 'f38a7c',
      'Jewelry / Handbags': 'a6749c',
      'Mobiles / Accessories': '3a63a8',
      'Perfume / Cosmetics': 'ec4f92',
      'Pets': 'e29423',
      'Services / Specialty Stores': 'efa1c5',
      'Sports / Outdoor / Fitness': '7ca180',
      'Toys & Hobbies / Gifts / Books': 'b2cce9'
    }
  end

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
