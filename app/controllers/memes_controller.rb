class MemesController < ApplicationController
  def new
    image = Image.find_by_id(params[:image_id]) || Image.order("RANDOM()").first
    @meme = Meme.new(image: image)
  end

  def create
    fabricator = MemeFabricator.new(meme_params)
    @meme = fabricator.meme
    fabricator.call
    flash[:notice] = "Meme successfully created"
    redirect_to @meme
  rescue
    render :new
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
