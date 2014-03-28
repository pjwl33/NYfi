class Hotspot < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :users

  validates :name, :address, :hood, :biz_url, :type, :noise_level, presence: true
  validates :power, :status, inclusion: { in: [true, false] }
  validates :dl_speed, :ul_speed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :yelp_rating, numericality: { greater_than_or_equal_to: 0 }
end