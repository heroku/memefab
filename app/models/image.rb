class Image < ApplicationRecord
  validates_presence_of :name, :remote_id
end
