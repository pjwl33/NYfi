require 'spec_helper'

describe User do
  it "has name, an email, password" do
    user = User.create!(name: "Paul", email: "paul@gmail.com", password: "hello123")
    expect(user.include?(:name, :address, :yelp_rating)).to be_true
    expect(user.password.count).to be_greater_than_or_equal(5)
  end
end