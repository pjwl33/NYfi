class RemoveRatingFromHotspots < ActiveRecord::Migration
  def change
    remove_column :hotspots, :rating, :decimal
  end
end
