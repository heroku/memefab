class Image < ApplicationRecord
  has_many :memes

  validates_presence_of :name, :upload_id
  validates_length_of :name, in: 3..50
end
