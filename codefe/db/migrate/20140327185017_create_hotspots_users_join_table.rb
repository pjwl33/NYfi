class CreateHotspotsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :hotspots_users, id: false do |t|
      t.integer :hotspot_id
      t.integer :user_id
    end
  end
end
