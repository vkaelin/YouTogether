class FavoriteVideosController < ApplicationController
  before_action :ensure_authenticated

  def new
    @favorite = FavoriteVideo.new
  end

  def create
    url = favorite_params[:url]
    regExp = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    match = url.match(regExp);

    if (match && match[2].length == 11)
      logger.info("url:" + match[2]);
      logger.info("good url up *************************")
    else
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

  private

  def favorite_params
    params.require(:favorite_video).permit(:url)
  end
end
