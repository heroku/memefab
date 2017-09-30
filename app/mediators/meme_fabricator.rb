class MemeFabricator < Mediator
  include ImagesHelper

  def initialize(model: Meme, uploader: Cloudinary::Uploader, **attributes)
    @attributes = attributes
    @model      = model
    @uploader   = uploader
  end

  def call
    validate_attributes
    memeify_image
    upload_image
    save_record
    meme
  end

  def meme
    @meme ||= model.new(attributes.merge(upload_id: upload_id))
  end

  private

  attr_reader :attributes, :memeified, :model, :uploader

  def validate_attributes
    raise ActiveRecord::RecordInvalid if meme.invalid?
  end


  def memeify_image
    @memeified ||= memeify(image.upload_id, meme.top, meme.bottom)
  rescue
    meme.errors.add(:base, "Error captioning meme")
    raise
  end

  def upload_image
    uploader.upload(memeified, public_id: upload_id)
  rescue
    meme.errors.add(:base, "Error uploading meme")
    raise
  end

  def save_record
    meme.save!
  rescue => e
    uploader.destroy(upload_id)
    raise
  end

  def image
    meme.image
  end

  def upload_id
    @upload_id ||= begin
      parts = [attributes[:top], attributes[:bottom], SecureRandom.hex(6)]
      parts.compact.map(&:parameterize).join('_')
    end
  end
end
