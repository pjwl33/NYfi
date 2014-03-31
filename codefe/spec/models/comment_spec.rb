require 'spec_helper'

describe Comment do
  it "has content, a hotspot, and timestamp" do
    hotspot = Hotspot.create!(name: "Code Cafe", address: "123 GA Street", wifi_tye: "Free", yelp_rating: 5.0)
    comment = Comment.create!(content: "Test comment", hotspot_id: hotspot)
    expect(comment.include?(:content, :hotspot_id, :created_at, :updated_at)).to be_true
  end
end