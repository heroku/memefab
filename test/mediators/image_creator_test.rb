require 'test_helper'

class ImagesCreatorTest < ActiveSupport::TestCase

  def test_image_uploaded
    name = "my-image"
    path = "https://some-place-on-internets"
    client = Minitest::Mock.new
    client.expect :upload, {} do |p, opts|
      p == path && opts[:public_id].start_with?(name)
    end
    ImageCreator.run(name: name, path: path, client: client)
    client.verify
  end

  def test_record_created
    name = "my-image"
    path = "https://some-place-on-internets"
    client = Minitest::Mock.new
    def client.upload(p, opts={}); {}; end;
    assert_difference 'Image.count' do
      ImageCreator.run(name: name, path: path, client: client)
    end
  end
end
