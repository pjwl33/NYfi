require 'spec_helper'

feature "comments can be created on a hotspot's page" do

  background { User.create(name: "Paul Lee", email: "pauly@gmail.com", password: "hello", password_confirmation: "hello", admin: true) }

  scenario "should allow a signed in user to comment on a hotspot" do
    sign_in("paul@ga.co", "hello")
    create_hotspot("Starbucks", "123 Everywhere Drive")
    fill_in("comment_content", with: "this is a cool place")
    click_button("Add Comment")

    expect(page).to have_content("123 Everywhere Drive")
    expect(page).to have_content("Comment added!")
    expect(page).to have_content("this is a cool place")
  end
end