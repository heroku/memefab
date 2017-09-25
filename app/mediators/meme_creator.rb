class ImageCreator < Mediator
  include ImagesHelper

  def initialize(top:, bottom:, image:, model: Meme, uploader: Cloudinary::Uploader)
    @top      = top
    @bottom   = bottom
    @image    = image
    @model    = model
    @uploader = uploader
  end

  def call
    upload
    begin
      create_record
    rescue
      unupload
      raise
    end
  end

  private

  attr_reader :path, :name, :model, :uploader

  def upload_id
    @upload_id ||= begin
      parts = [top, bottom, image.name, SecureRandom.hex(6)]
      parts.compact.join('-')
    end
  end

  def transform_url
    @transform_url = meme_transformation_url(image.upload_id, top, bottom)
  end

  def upload
    uploader.upload(transform_url, public_id: upload_id)
  end

  def create_record
    model.create!(
      top:       top,
      bottom:    bottom,
      image:     image,
      upload_id: upload_id
    )
  end

  def unupload
    uploader.destroy(upload_id)
  end
end
