user1 = User.create name: "Paul Lee", email: "pauly0418@gmail.com", password: "hello", password_confirmation: "hello", admin: true
user1 = User.create name: "Luke Lee", email: "luke.lee@gmail.com", password: "hello", password_confirmation: "hello", admin: false

require_relative 'seed_data.rb'
seed_data = seeder

seed_data.each do |hotspot|
  Hotspot.create({
    name: hotspot[1],
    address: "#{hotspot[2]} #{hotspot[3]} #{hotspot[7]}",
    biz_url: hotspot[4],
    wifi_type: hotspot[6],
    phone: hotspot[5]
   })
end
