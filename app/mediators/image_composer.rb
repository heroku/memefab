class ImageComposer < Mediator
  def initialize(path:, name:, uploader: Cloudinary::Uploader, model: Image)
    @path     = path
    @name     = name
    @uploader = uploader
    @model    = model
  end

  def call
    upload_image
    create_record
  end

  def image
    @image ||= Image.new(name: name, upload_id: upload_id)
  end

  private

  attr_reader :path, :name, :model, :uploader

  def upload_image
    uploader.upload(path,
      allowed_formats: "jpg",
      public_id: upload_id
    )
  end

  def create_record
    model.create!(name: name, upload_id: upload_id)
  rescue
    uploader.destroy(upload_id)
    raise
  end

  def upload_id
    @upload_id ||= begin
      prefix = name.gsub("'","").parameterize
      "#{prefix}_#{SecureRandom.hex(6)}"
    end
  end
end
