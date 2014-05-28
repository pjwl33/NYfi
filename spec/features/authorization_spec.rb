require 'spec_helper'

feature "a user can sign in" do

  background { User.create(name: "Paul Lee", email: "pauly0418@gmail.com", password: "hello", password_confirmation: "hello") }

  scenario "should sign in the user given a valid Email and Password" do
    sign_in("pauly0418@gmail.com", "hello")
    expect(page).to have_content("Welcome back Paul Lee!")
  end

  scenario "should not sign in a user with invalid  email or password" do
    sign_in("paul@ga.co", "poopface")
    expect(page).to have_content("Forgot your password?")
  end

end