# frozen_string_literal: true

module Gate
  module Exceptions
    ##
    #
    class SiteAlreadyExists < Ant::Exceptions::AntFail
      def initialize(data)
        super('The given site already exists!', nil, data)
      end
    end

    ##
    #
    class UserAlreadyExists < Ant::Exceptions::AntFail
      def initialize(data)
        super('The given user already exists!', nil, data)
      end
    end

    ##
    #
    class UserExistsOnSite < Ant::Exceptions::AntFail
      def initialize(user, site)
        super('The user is registered on that site', nil,
              user: user, site: site)
      end
    end

    ##
    #
    class SiteNotFound < Ant::Exceptions::AntFail
      def initialize(site)
        super('Site not found!', nil, site: site)
      end
    end

    ##
    #
    class UserNotFound < Ant::Exceptions::AntFail
      def initialize(user)
        super('User not found!', nil, user: user)
      end
    end

    ##
    #
    class UserNotRegistered < Ant::Exceptions::AntFail
      def initialize(user, site)
        super('The user is not registered on that site', nil,
        user: user, site: site)
      end
    end

    ##
    #
    class WrongPassword < Ant::Exceptions::AntFail
      def initialize
        super('Password is incorrect or user does not exists, try again')
      end
    end

    ##
    #
    class InvalidToken < Ant::Exceptions::AntFail
      def initialize
        super('Token provided is not valid')
      end
    end

    ##
    #
    class TokenExpired < Ant::Exceptions::AntFail
      def initialize(token)
        super('The given token has expired',
               server_time: Time.now, token_expiration_time: token.valid_until)
      end
    end
  end
end
