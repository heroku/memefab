module ImagesHelper
  def memeify(upload_id, top_text, bottom_text)
    transforms = [{ width: 600, crop: :scale }]
    transforms << meme_text_overlay(top_text, :north) if top_text.present?
    transforms << meme_text_overlay(bottom_text, :south) if bottom_text.present?
    Cloudinary::Utils.cloudinary_url(upload_id, transformation: transforms)
  end

  private

  def meme_text_overlay(text, gravity)
    {
      overlay: {
        text: text.upcase,
        font_family: 'Impact',
        font_size: 100,
        font_weight: :bold,
        stroke: :stroke,
      },
      width: 580,
      height: 100,
      gravity: gravity,
      color: "#FFF",
      crop: :scale,
      border: "8px_solid_black"
    }
  end
end
