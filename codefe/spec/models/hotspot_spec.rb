require 'spec_helper'

describe Hotspot do
  it "has name, an address, wifi-type of Free or Fee-based, yelp-rating" do
    hotspot = Hotspot.create!(name: "Code Cafe", address: "123 GA Street", wifi_type: "Free", yelp_rating: 5.0)
    expect(hotspot.name).to eq("Code Cafe")
    expect(hotspot.address).to eq("123 GA Street")
    expect(hotspot.yelp_rating).to eq(5.0)
    expect(hotspot.wifi_type).to eq("Free")
  end
end