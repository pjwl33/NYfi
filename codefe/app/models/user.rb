class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :hotspots

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 5 }

  def  self.add_hotspot(user_id, hotspot_id)
    user = User.find user_id
    hotspot = Hotspot.find hotspot_id
    user.hotspots << hotspot
    return hotspot
  end

  def self.remove_hotspot(user_id, hotspot_id)
    user = User.find user_id
    hotspot = Hotspot.find hotspot_id
    user.hotspots.destroy(hotspot)
  end


end
