class CreateHotspots < ActiveRecord::Migration
  def change
    create_table :hotspots do |t|
      t.string "name"
      t.string "address"
      t.boolean "free"
      t.float "wifi_rating"
      t.float "yelp_rating"
      t.float "wifi_speed"
    end
  end
end
