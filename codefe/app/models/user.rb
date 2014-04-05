class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :hotspots

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 5 }

  def add_hotspot(hotspot)
    self.hotspots << hotspot
  end

  def remove_hotspot(hotspot)
    if current_user.id == self.id
      self.hotspots.destroy(hotspot)
    else
      return false
    end
  end


end
