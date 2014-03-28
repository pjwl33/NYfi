class CreateHotspots < ActiveRecord::Migration
  def change
    create_table :hotspots do |t|
      t.string :name
      t.string :address
      t.string :cross_street
      t.string :hood
      t.string :biz_url
      t.string :img_url
      t.string :type
      t.boolean :power
      t.boolean :status
      t.integer :dl_speed
      t.integer  :ul_speed
      t.decimal :yelp_rating, precision: 8, scale: 2
      t.string :noise_level
      t.boolean :good_for_kids
    end
  end
end
