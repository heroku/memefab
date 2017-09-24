require "test_helper"

class MemeTest < ActiveSupport::TestCase
  def meme
    @meme ||= Meme.new
  end

  def test_validates_text_lengths
    text = 25.times.map { "coffee" }.join('')
    meme.remote_id = SecureRandom.uuid
    meme.top = text
    meme.bottom = text
    refute meme.valid?
    assert_includes meme.errors[:top].first, "is too long"
    assert_includes meme.errors[:bottom].first, "is too long"
  end

  def test_validates_required_attributes
    refute meme.valid?
    assert_includes meme.errors[:remote_id], "can't be blank"
    assert_includes meme.errors[:image], "can't be blank"
  end
end
