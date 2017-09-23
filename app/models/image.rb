class Image < ApplicationRecord
  validates_presence_of :name, :remote_id
  validates_length_of :name, in: 3..75
end
