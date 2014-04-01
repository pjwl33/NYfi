class Hotspot < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :address, presence: true
  validates :wifi_type, inclusion: { in: ["Free", "Fee-based"] }
  validates_numericality_of :yelp_rating, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0
  validates_format_of :yelp_rating, with: /\d[.]\d/

  #Google Static Map API key and point
  def map_key
    return "http://maps.googleapis.com/maps/api/staticmap?center=#{self.address.split.join("+")}&zoom=15&size=600x300&markers=size:mid%=color:red%7Clabel:S%7C#{self.address.split.join("+")}&sensor=true_or_false&key=AIzaSyAf-kaHYTcunJRivgwJKLC1WjJl4zXgJIk"
  end

  #Yelp API for specific business by address and name
  def yelp_search
    client = Yelp::Client.new
    request = Yelp::V2::Search::Request::Location.new(
      term: "#{self.name}",
      address: "#{self.address}",
      city: "New York"
    )
    response = client.search(request)
    # hash return - could DRY up bottom algo?
    if response && response["businesses"]
      if response["businesses"].first
        rating = response["businesses"].first["rating"] || 0.0
        img_url = response["businesses"].first["image_url"] || "Not Available"
      end
      info_array = [rating, img_url]
      return info_array
    else
      info_array = [0.0, "Not Available"]
      return info_array
    end
  end

end
