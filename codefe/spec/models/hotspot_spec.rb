  require 'spec_helper'

describe Hotspot do
  subject(:hotspot){Hotspot.create!(name: "Code Cafe", address: "123 GA Street", wifi_type: "Free", yelp_rating: 5.0)}

  describe ".new" do
    it "has name, an address, wifi-type of Free or Fee-based, yelp-rating" do
      expect(hotspot.name).to eq("Code Cafe")
      expect(hotspot.address).to eq("123 GA Street")
      expect(hotspot.yelp_rating).to eq(5.0)
      expect(hotspot.wifi_type).to eq("Free")
    end
  end

  describe "#map_key" do
    it "returns a Google Maps API URL of a static map image" do
      expect(hotspot.map_key).to eq("http://maps.googleapis.com/maps/api/staticmap?center=#{hotspot.address.split.join("+")}&zoom=15&size=550x300&markers=size:mid%=color:red%7Clabel:H%7C#{hotspot.address.split.join("+")}&sensor=true_or_false&key=AIzaSyAf-kaHYTcunJRivgwJKLC1WjJl4zXgJIk")
    end
  end

  describe "#yelp_search" do
    it "returns an array of the hotspot's Yelp rating and Image URL, in that order" do
      hotspot.yelp_search[0].should be >= 0.0
      hotspot.yelp_search[0].should be <= 5.0
      expect(hotspot.yelp_search[1]).to eq(nil)
    end
  end

  describe "#recommend" do
    it "returns an array of other favorited hotspots by users, given the current hotspot is liked by other users as well" do
      expect(hotspot.recommend).to eq([])
      #returning empty array at this point, because no other users favorited hotspots to compare
    end
  end

end
