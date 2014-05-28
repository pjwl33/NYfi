class Comment < ActiveRecord::Base
  belongs_to :hotspot
  validates :content, :hotspot_id, presence: true
end
