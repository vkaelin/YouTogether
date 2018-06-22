class FavoriteVideosController < ApplicationController
  before_action :ensure_authenticated

  def new
    @favorite = FavoriteVideo.new
  end

  def create
    @favorite = current_user.favorite_videos.new(favorite_params)
    @favorite.user = current_user
    @favorite.save
    if(@favorite.save)
      redirect_to(account_path)
    else
      render 'new'
    end
  end

  private

  def favorite_params
    params.require(:favorite_video).permit(:url)
  end
end
