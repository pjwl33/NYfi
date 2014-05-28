  require 'spec_helper'

describe Hotspot do
  subject(:hotspot){Hotspot.create!(name: "Code Cafe", address: "123 GA Street", wifi_type: "Free", yelp_rating: 5.0)}

  it { should validate_presence_of :name}
  it { should validate_presence_of :address}
  it { should ensure_inclusion_of(:wifi_type).in_array ["Free", "Fee-based"] }
  it { should validate_numericality_of(:yelp_rating).is_greater_than_or_equal_to(0.0)}
  it { should validate_numericality_of(:yelp_rating).is_less_than_or_equal_to(5.0)}
  it { should allow_value(4.5).for :yelp_rating }
  it { should_not allow_value(10.2).for :yelp_rating}
  it { should_not allow_value(-10.2).for :yelp_rating}
  it { should have_many :comments }
  it { should have_and_belong_to_many :users }

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
