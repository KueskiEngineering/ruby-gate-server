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
    class PermissionNotFound < Ant::Exceptions::AntFail
      def initialize(permission)
        super('Permission not found!', nil, permission: permission)
      end
    end

    ##
    #
    class RoleNotFound < Ant::Exceptions::AntFail
      def initialize(role)
        super('Role not found!', nil, role: role)
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

    ##
    #
    class PermissionAlreadyExists < Ant::Exceptions::AntFail
      def initialize(data)
        super('The permission is already registered', nil, data)
      end
    end

    ##
    #
    class UserHasNotPermission < Ant::Exceptions::AntFail
      def initialize(data)
        super('User has not permission for that request', nil, data)
      end
    end

    ##
    #
    class RoleAlreadyExists < Ant::Exceptions::AntFail
      def initialize(data)
        super('The role is already registered', nil, data)
      end
    end

    ##
    #
    class PermissionAlreadyAssigned < Ant::Exceptions::AntFail
      def initialize(data)
        super('The permission is already assigned', nil, data)
      end
    end
  end
end
