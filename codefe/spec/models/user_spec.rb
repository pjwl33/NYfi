require 'spec_helper'

describe User do
  it "has name, an email, password" do
    user = User.create!(name: "Paul", email: "paul@gmail.com", password: "hello123", password_confirmation: "hello123", admin: true)
    expect(user.name).to eq("Paul")
    expect(user.email).to eq("paul@gmail.com")
    expect(user.admin).to eq(true)
    expect(user.password).to eq(user.password_confirmation)
    expect(user.password.length).to be >= 5
  end
end