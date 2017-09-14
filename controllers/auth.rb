# frozen_string_literal: true

require 'bcrypt'
require_relative '../lib/exception'
require_relative 'token'

module Gate
  module Controllers
    ##
    #
    class Auth
      include Exceptions

      def initialize(site, user, password)
        @site = site
        @user = user
        @password = password
        @data = Services.database[:auth]
                        .where(site_id: site.id, user_id: user.id)
                        .first
      end

      def generate_token
        raise(WrongPassword) unless valid_password?
        Token.create(username: @user.name, site: @site.name)
      end

      def exists?
        !@data.nil?
      end

      def register
        raise(UserExistsOnSite.new(@user.name, @site.name)) if exists?
        @data = {
          password: BCrypt::Password.create(@password),
          user_id: @user.id,
          site_id: @site.id,
          created_at: Time.now,
          updated_at: Time.now,
          enabled: true
        }
        Services.database[:auth].insert(@data)
      end

      def valid_password?
        raise(WrongPassword) unless exists?
        BCrypt::Password.new(@data[:password]) == @password
      end

      def to_h
        {
          site: @site.name,
          user: @user.name,
          created_at: @data[:created_at],
          updated_at: @data[:updated_at],
          enabled: @data[:enabled]
        }
      end
    end
  end
end
