require 'spec_helper'

describe Hotspot do
  it "has name, an address, wifi-type of Free or Fee-based, yelp-rating" do
    hotspot = Hotspot.create!(name: "Code Cafe", address: "123 GA Street", wifi_tye: "Free", yelp_rating: 5.0)
    expect(hotspot.include?(:name, :address, :yelp_rating)).to be_true
    expect(hotspot.wifi-type).to include?("Free", "Fee-based")
  end
end