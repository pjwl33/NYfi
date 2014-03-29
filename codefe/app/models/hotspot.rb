class Hotspot < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :users

  validates :name, :address, presence: true
  validates :wifi_type, inclusion: { in: [true, false] }
  # validates :yelp_rating, numericality: { greater_than_or_equal_to: 0 }

  # @@foursquare_url = "https://api.foursquare.com/v2/venues/search?client_id=HTE5QZE5G1GZHPFBSALDZPQ5DP1YCTOZBOHY1024QST4AUEC&client_secret=NTF2HTV4X4IN5QB4ZSOUVSEQV4I4K1KI5D0MS3P4PLB3EAUP&v=20130815&near=new+york&query=coffee&intent=browse&limit=10"

  # def self.search_foursquare
  #   response = JSON.parse(HTTParty.get(@@foursquare_url))
  #   return response
  # end


end