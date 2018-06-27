module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", "User #{current_user.id}"
    end

    private

    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end

    def find_verified_user
      if session && session['user_id']
        User.find(session['user_id'])
      else
        reject_unauthorized_connection
      end
    end

  end
end
