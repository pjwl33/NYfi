class Hotspot < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :users

  validates :name, :address, :wifi_type, presence: true
  validates :yelp_rating, numericality: { greater_than_or_equal_to: 0 }

  def yelp_search
    client = Yelp::Client.new
    request = Yelp::V2::Search::Request::Location.new(
      term: "#{self.name}",
      address: "#{self.address}",
      city: "New York"
    )
    response = client.search(request)
    # hash return
    if response["businesses"].first["rating"] != nil || response["businesses"].first["image_url"] != nil
      rating = response["businesses"].first["rating"]
      img_url = response["businesses"].first["image_url"]
      info_array = [rating, img_url]
      return info_array
    else
      rating = "Not Available"
      img_url = "Not Available"
      info_array = [rating, img_url]
      return info_array
    end
  end


end