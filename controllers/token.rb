# frozen_string_literal: true

require 'jwt'

##
# A token
module Gate
  module Controllers
    ##
    #
    class Token
      # 4 hours for expiration time
      DEFAULT_EXPIRATION_TIME = 60 * 60 * 4
      include Exceptions
      class << self
        def create(data)
          data[:expiration_time] ||= Time.now + DEFAULT_EXPIRATION_TIME
          data[:creation_time] = Time.now
          token = JWT.encode(data, Services.jwt_private_key, 'RS512')
          new(token, data)
        end

        def parse(token)
          data, _payload = JWT.decode(token, Services.jwt_public_key,
                                      true, algoritm: 'RS512')
          new(token, data.symbolize_keys)
        rescue JWT::VerificationError => _
          raise(Exceptions::InvalidToken)
        end
      end

      # rubocop: disable Stye/PredicateName
      def has_role?(role)
        return false if @data[:roles].nil?
        @data[:roles].include?(role)
      end
      # rubocop: enable Stye/PredicateName

      def username
        @data[:username]
      end

      def expired?
        @data[:expiration_time].nil? || @data[:expiration_time] < Time.now
      end

      def to_h
        {
          token: @token,
          data: @data
        }
      end

      def valid_until
        @data[:expiration_time]
      end

      private

      def initialize(token, data)
        @token = token
        @data = data
        raise(TokenExpired, self) if expired?
      end
    end
  end
end
