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
    assert client.verify
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

  def test_record_not_created_on_upload_error
    name = "my-image"
    path = "https://some-place-on.internet/cat.mov"
    client = Minitest::Mock.new
    def client.upload(p, opts={})
      raise "Invalid file type"
    end
    assert_no_difference 'Image.count' do
      assert_raises do
        ImageCreator.run(name: name, path: path, client: client)
      end
    end
  end

  def test_remote_image_removed_on_record_creation_error
    name = SecureRandom.hex(100)
    path = "https://some-place-on.internet/cat.png"
    client = Minitest::Mock.new
    def client.upload(p, opts={}); {}; end;
    client.expect :destroy, nil, [String]
    assert_no_difference 'Image.count' do
      assert_raises do
        ImageCreator.run(name: name, path: path, client: client)
      end
    end
    client.verify
  end
end
