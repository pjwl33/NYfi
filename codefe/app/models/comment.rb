class Comment < ActiveRecord::Base
  belongs_to :hotspot
  validates :content, :hotspot, :updated_at, presence: true
end