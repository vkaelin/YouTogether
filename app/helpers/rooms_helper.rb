module RoomsHelper
  def has_joined?(room)
    return unless logged_in?
    current_user.rooms.exists?(room.id)
  end
end
