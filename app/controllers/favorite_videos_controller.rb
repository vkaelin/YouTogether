class FavoriteVideosController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated
  before_action :load_favorite,                 only: [:destroy]
  before_action :authorize_to_delete_favorite,  only: [:destroy]

  def new
    @favorite = FavoriteVideo.new
  end

  def create
    url = favorite_params[:url]
    regExp = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    match = url.match(regExp);

    unless (match && match[2].length == 11)
      @favorite = FavoriteVideo.new
      flash.now[:alert] = "The link of the video is invalid. Please try again"
      render 'new'
      return
    end

    @favorite = current_user.favorite_videos.new(url: match[2])
    @favorite.user = current_user
    if(@favorite.save)
      redirect_to(account_path)
    else
      flash.now[:alert] = "The link of the video is invalid. Please try again"
      render 'new'
    end
  end

  def destroy
    @favorite = FavoriteVideo.find(params[:id])
    @favorite.destroy
  end

  private

  def favorite_params
    params.require(:favorite_video).permit(:url)
  end

  def load_favorite
    @favorite = FavoriteVideo.find(params[:id])
  end

  def authorize_to_delete_favorite
    redirect_to(account_path) unless(can_delete?(@favorite))
  end
end
