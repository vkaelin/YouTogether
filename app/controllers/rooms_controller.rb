class RoomsController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated, only: [:new, :create, :show]
  before_action :load_room,            only: [:show, :destroy]
  before_action :can_access_room,      only: [:show]
  before_action :can_destroy_room,     only: [:destroy]

  def index
    @search_term = params[:q]
    @no_search = @search_term.nil?
    @rooms = Room.search(@search_term).page(params[:page])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    if (@room.save)
      @room.users << current_user
      redirect_to(room_path(@room))
    else
      render 'new'
    end
  end

  def destroy
    @room.destroy
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

  def can_destroy_room
    redirect_to(account_path) unless(can_delete_room?(@room))
  end
end
