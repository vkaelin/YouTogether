module RolesHelper
  def can_delete_fav?(favorite_video)
    case(current_user.role)
    when 'admin' then true
    when 'registered' then (favorite_video.user == current_user)
    else false
    end
  end

  def can_delete_room?(room)
    case(current_user.role)
    when 'admin' then true
    when 'registered' then (room.owner == current_user)
    else false
    end
  end

  def owns_room?(room)
    room.owner == current_user
  end

  def is_admin?()
    current_user.role == 'admin'
  end
end
