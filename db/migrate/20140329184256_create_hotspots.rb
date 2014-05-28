class CreateHotspots < ActiveRecord::Migration
  def change
    create_table :hotspots do |t|
      t.string :name
      t.string :address
      t.string :biz_url
      t.string :wifi_type
      t.string :phone
      t.string :img_url
      t.decimal :yelp_rating, precision: 8, scale: 2
    end
  end
end
