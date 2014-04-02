class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :hotspots

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, length: { minimum: 5 }
  # validates :admin, inclusion: { in: [true, false] }
end
