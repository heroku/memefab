class ImageCreator < Mediator
  def initialize(path:, name:, uploader: Cloudinary::Uploader, model: Image)
    @path     = path
    @name     = name
    @uploader = uploader
    @model    = model
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
    @upload_id ||= "#{name.parameterize}-#{SecureRandom.hex(6)}"
  end

  def upload
    uploader.upload(path,
      allowed_formats: "png,jpg,gif",
      public_id: upload_id
    )
  end

  def create_record
    model.create!(name: name, upload_id: upload_id)
  end

  def unupload
    uploader.destroy(upload_id)
  end
end
