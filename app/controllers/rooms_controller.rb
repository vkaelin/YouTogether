class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if (@room.save)
      session[:room_id] = @room.id
      redirect_to(room_path(@room))
    else
      render 'new'
    end
  end

  def show
    @room = Room.find(params[:id])
    @url = @room.video
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
