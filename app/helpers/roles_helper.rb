module RolesHelper
  def can_delete?(favorite_video)
    case(current_user.role)
    when 'admin' then true
    when 'registered' then (favorite_video.user == current_user)
    else false
    end
  end

  def is_admin?()
    current_user.role == 'admin'
  end
end
