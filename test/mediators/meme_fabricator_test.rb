require 'test_helper'

class MemeFabricatorTest < ActiveSupport::TestCase
  def image
    @image ||= Image.create(name: "biznesscat", upload_id: SecureRandom.uuid)
  end

  def test_meme_uploaded
    top = "chocolate"
    bottom = "bananas"
    uploader = Minitest::Mock.new
    uploader.expect :upload, {} do |url, public_id:|
      url.include?(image.upload_id) &&
        url.include?(top.upcase) &&
        url.include?(bottom.upcase) &&
        public_id.include?(top) &&
        public_id.include?(bottom)
    end
    MemeFabricator.run(top: top, bottom: bottom, image_id: image.id,
                       uploader: uploader)
    assert uploader.verify
  end

  def test_record_created
    top = "coffee"
    bottom = "sprinkles"
    uploader = Minitest::Mock
    def uploader.upload(p, opts={}); {}; end;
    assert_difference 'Meme.count' do
      meme = MemeFabricator.run(top: top, bottom: bottom, image_id: image.id,
                                uploader: uploader)
      assert_equal meme.top, top
      assert_equal meme.bottom, bottom
      assert_equal meme.image_id, image.id
      assert meme.upload_id
    end
  end

  def test_record_not_created_on_upload_error
    top = "redemption"
    bottom = "song"
    uploader = Minitest::Mock.new
    def uploader.upload(p, opts={})
      raise "Invalid file type"
    end
    assert_no_difference 'Meme.count' do
      assert_raises do
        MemeFabricator.run(top: top, bottom: bottom, image_id: image.id,
                           uploader: uploader)
      end
    end
  end

  def test_remote_image_not_uploaded_on_validation_error
    top = 10.times.map { "yellow" }.join('-')
    bottom = "submarine"
    uploader = Minitest::Mock.new
    def uploader.upload(p, opts={})
      raise "Uploader shoud not upload"
    end
    assert_no_difference 'Meme.count' do
      assert_raises ActiveRecord::RecordInvalid do
        MemeFabricator.run(top: top, bottom: bottom, image_id: image.id,
                           uploader: uploader)
      end
    end
  end
end
