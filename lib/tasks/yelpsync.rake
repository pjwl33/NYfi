task yelpsync: :environment do
  desc "Syncs hotspots with Yelp for ratings and image"
  puts "Updating"
  Hotspot.yelpsync
end