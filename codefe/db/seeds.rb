# # def seeder

# #   return wifi_data
# # end

# # seeder.each do |hotspot|
# #   Hotspot.create({
# #     name: hotspot[1],
# #     address: "#{hotspot[2]}, #{hotspot[3]}, #{hotspot[7]}",
# #     biz_url: hotspot[4],
# #     wifi_type: hotspot[6],
# #     phone: hotspot[5]
# #    })
# # end

# Hotspot.all.each do |hs|
#   hs.update({
#   yelp_rating: hs.yelp_search[0],
#   img_url: hs.yelp_search[1]
#   })
# end


