class Hotspot < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :address, presence: true
  validates :wifi_type, inclusion: { in: ["Free", "Fee-based"] }
  validates_numericality_of :yelp_rating, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 5.0
  validates_format_of :yelp_rating, with: /\d[.]\d/

  #Google Static Map API key and point
  def map_key
    return "http://maps.googleapis.com/maps/api/staticmap?center=#{self.address.split.join("+")}&zoom=15&size=550x300&markers=size:mid%=color:red%7Clabel:H%7C#{self.address.split.join("+")}&sensor=true_or_false&key=AIzaSyAf-kaHYTcunJRivgwJKLC1WjJl4zXgJIk"
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
        img_url = response["businesses"].first["image_url"] || "http://upload.wikimedia.org/wikipedia/en/d/d6/Image_coming_soon.png"
      end
      info_array = [rating, img_url]
      return info_array
    else
      info_array = [0.0, "http://upload.wikimedia.org/wikipedia/en/d/d6/Image_coming_soon.png"]
      return info_array
    end
  end

  def yelp_sync
    if admin?
      hotspots.each do |hs|
        if hs.yelp_rating == nil && hs.img_url == nil
          hs.update({
          yelp_rating: hs.yelp_search[0],
          img_url: hs.yelp_search[1]
          })
        end
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

end
