class Area < ApplicationRecord
  belongs_to :project
  belongs_to :map

  validates_presence_of :coords
  
  has_many :areas_deals, :dependent => :destroy
  has_many :deals, through: :areas_deals
  
  has_many :primary_deals, :dependent => :destroy

  def self.lease_status_color
    {
      'Available': 'd13e27',
      'Prospect': 'e5ba21',
      'LOI': 'f16528',
      'At Lease': '15958A',
      'Leased': '8bc53f'
    }
  end
  
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

end
