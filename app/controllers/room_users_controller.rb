class RoomUsersController < ApplicationController
  before_action :ensure_authenticated
  before_action :set_room

  def create
    @room_user = @room.users.find_by_id(current_user.id)
    if @room_user.nil?
      @room.users << current_user
    end
      redirect_to @room
  end

  def destroy
    @room.users.delete(current_user)
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end
