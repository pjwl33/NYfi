class Hotspot < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :address, presence: true

  SEARCH_URL = "http://maps.googleapis.com/maps/api/staticmap?center="

  #Google Static Map API key and point
  def map_key
    return "#{SEARCH_URL}#{self.address.split.join("+")}&zoom=15&size=550x300&markers=size:mid%=color:red%7Clabel:H%7C#{self.address.split.join("+")}&sensor=true_or_false&key=#{ENV["GOOGLE_MAPS_API_KEY"]}"
  end

  #Yelp API for specific business by address and name
  def yelp_search
    begin
      client = Yelp::Client.new
      request = Yelp::V2::Search::Request::Location.new(
        term: "#{self.name}",
        address: "#{self.address}",
        city: "New York"
        )
      response = client.search(request)
      rating = response["businesses"].first["rating"]
      img_url = response["businesses"].first["image_url"]
      info_array = [rating, img_url]
    rescue
      info_array = [0.0, "http://upload.wikimedia.org/wikipedia/en/d/d6/Image_coming_soon.png"]
    end
    return info_array
  end

  def self.search(name, location, rating, wifi)
    if name
      hotspots = Hotspot.all conditions: ['name LIKE ?', "%#{name.capitalize}%"]
    elsif location
      hotspots = Hotspot.all conditions: ['address LIKE ?', "%#{location.capitalize}%"]
    elsif rating
      hotspots = Hotspot.all conditions: {yelp_rating: rating.to_d}
    elsif wifi
      hotspots = Hotspot.all conditions: {wifi_type: wifi}
    end
    return hotspots
  end

  def self.yelpsync
    Hotspot.all.each do |hs|
      if hs.yelp_rating == nil || hs.yelp_rating == 0.0
        hs.update({
          yelp_rating: hs.yelp_search[0],
        })
      end
      if hs.img_url == nil || hs.img_url == "http://upload.wikimedia.org/wikipedia/en/d/d6/Image_coming_soon.png"
        hs.update({
          img_url: hs.yelp_search[1],
        })
      end
    end
  end
  #recommending other users' favorited hotspots, based on hotspot show
  def recommend
    recs = []
    User.all.each do |user|
      if user.hotspots.include?(self)
        user.hotspots.each do |hs|
          recs << hs
        end#user.hotspots end
      end#if include? end
      return recs.uniq
    end#users.each end
  end#method end

  def closest_search(hotspot)
    #self.locate and then show closests hotspots in radius
  end

end
