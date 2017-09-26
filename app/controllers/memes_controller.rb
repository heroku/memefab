class MemesController < ApplicationController
  def new
    image = Image.find_by_id(params[:image_id]) || Image.order("RANDOM()").first
    @meme = Meme.new(image: image)
  end

  def create
    image = Image.find_by_id(meme_params.delete(:image_id))
    @meme = MemeCreator.run(meme_params.merge(image: image))
    redirect_to @meme
  end

  def show
    @meme = Meme.find(params[:id])
  end

  private

  def meme_params
    @meme_params ||= params.require(:meme)
                           .permit(:top, :bottom, :image_id)
                           .to_hash
                           .symbolize_keys
  end
end
