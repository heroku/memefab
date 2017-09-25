class ImageCreator < Mediator

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
    Cloudinary::Utils.cloudinary_url(image.upload_id,
      transformation: [
        {
          width: 600,
          crop: :scale
        },
        {
          overlay: {
            text: top.upcase,
            font_family: 'Impact',
            font_size: 100,
            font_weight: :bold,
            stroke: :stroke,
          },
          width: 580,
          height: 100,
          gravity: :north,
          color: "#FFF",
          crop: :scale,
          border: "8px_solid_black"
        },
        {
          overlay: {
            text: bottom.upcase,
            font_family: 'Impact',
            font_size: 100,
            font_weight: :bold,
            stroke: :stroke,
          },
          width: 580,
          height: 100,
          gravity: :south,
          color: "#FFF",
          crop: :scale,
          border: "8px_solid_black"
        }
      ]
    )
  end

  def upload
    uploader.upload(transform_url)
  end

  def upload
    uploader.upload(path,
      allowed_formats: "png,jpg,gif",
      public_id: upload_id
    )
  end

  def create_record
    model.create!(
      top: top,
      bottom: bottom,
      image: image,
      upload_id: upload_id
    )
  end

  def unupload
    uploader.destroy(upload_id)
  end
end
