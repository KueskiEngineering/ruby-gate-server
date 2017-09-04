# frozen_string_literal: true

require_relative '../lib/services'
require_relative '../lib/exception'
require 'bcrypt'

module Gate
  module Controllers
    ##
    # this class handles user
    class User
      include Exceptions
      def initialize(user)
        @user = user
        @dataset = Services.database[:user].where(username: user)
        @data = @dataset.first
      end

      def exists?
        !@data.nil?
      end

      def create
        raise(UserAlreadyExists, @data) if exists?
        @data = {
          username: @user,
          created_at: Time.now,
          updated_at: Time.now,
          enabled: true
        }
        @data[:user_id] = Services.database[:user].insert(@data)
      end

      def id
        @data[:user_id]
      end

      def name
        @data[:username]
      end

      def to_h
        @data
      end
    end
  end
end
