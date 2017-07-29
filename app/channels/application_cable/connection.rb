module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected
#check if user is authenticated by devise
    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorised_connection
      end
    end
  end
end
