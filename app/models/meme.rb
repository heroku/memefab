class Meme < ApplicationRecord
  belongs_to :image

  validates_presence_of :upload_id, :image
  validates_length_of :top, :bottom, maximum: 50
end
