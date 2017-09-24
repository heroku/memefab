require 'test_helper'

class ImagesCreatorTest < ActiveSupport::TestCase

  def test_image_uploaded
    name = "my-image"
    path = "https://some-place-on-internets"
    uploader = Minitest::Mock.new
    uploader.expect :upload, {} do |p, opts|
      p == path && opts[:public_id].start_with?(name)
    end
    ImageCreator.run(name: name, path: path, uploader: uploader)
    assert uploader.verify
  end

  def test_record_created
    name = "my-image"
    path = "https://some-place-on-internets"
    uploader = Minitest::Mock.new
    def uploader.upload(p, opts={}); {}; end;
    assert_difference 'Image.count' do
      ImageCreator.run(name: name, path: path, uploader: uploader)
    end
  end

  def test_record_not_created_on_upload_error
    name = "my-image"
    path = "https://some-place-on.internet/cat.mov"
    uploader = Minitest::Mock.new
    def uploader.upload(p, opts={})
      raise "Invalid file type"
    end
    assert_no_difference 'Image.count' do
      assert_raises do
        ImageCreator.run(name: name, path: path, uploader: uploader)
      end
    end
  end

  def test_remote_image_removed_on_record_creation_error
    name = SecureRandom.hex(100)
    path = "https://some-place-on.internet/cat.png"
    uploader = Minitest::Mock.new
    def uploader.upload(p, opts={}); {}; end;
    uploader.expect :destroy, nil, [String]
    assert_no_difference 'Image.count' do
      assert_raises do
        ImageCreator.run(name: name, path: path, uploader: uploader)
      end
    end
    uploader.verify
  end
end
