require 'spec_helper'

describe User do

  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :password }
  it { should have_and_belong_to_many :hotspots }

  it do
    User.create({ name: "Paul Lee", email: "pauly0418@gmail.com", password: "hello", password_confirmation: "hello", admin: true })
    should validate_uniqueness_of(:email)
  end

end