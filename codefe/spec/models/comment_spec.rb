require 'spec_helper'

#rake db:test:prepare

describe Comment do
  it "has content, a hotspot, and timestamp" do
    hotspot = Hotspot.create!(name: "Code Cafe", address: "123 GA Street", wifi_type: "Free", yelp_rating: 5.0)
    comment = Comment.create!(content: "Test comment", hotspot_id: hotspot.id)
    expect(comment.content).to eq("Test comment")
    expect(comment.hotspot).to eq(hotspot)
  end
end