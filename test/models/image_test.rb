require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "should require attributes" do
    image = Image.new
    refute image.valid?
    assert_equal [:name, :upload_id], image.errors.keys
  end
end
