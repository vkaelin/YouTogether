class RoomsController < ApplicationController
  before_action :ensure_authenticated, only: [:new, :create, :show]
  before_action :load_room,            only: [:show]
  before_action :can_access_room,      only: [:show]

  def index
    @search_term = params[:q]
    @no_search = @search_term.nil?
    @rooms = Room.search(@search_term)
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
    @messages = @room.messages.most_recent(100)
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def load_room
    @room = Room.find(params[:id])
  end

  def can_access_room
    redirect_to(rooms_path) unless(current_user.rooms.exists?(@room.id))
  end
end
