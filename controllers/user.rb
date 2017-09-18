# frozen_string_literal: true

require_relative '../lib/services'
require_relative '../lib/exception'
require_relative 'name_list_controller'
require 'bcrypt'

module Gate
  module Controllers
    ##
    # this class handles user
    class User < NameListController
      include Exceptions
      def id_field
        :user_id
      end

      def name_field
        :username
      end

      def control_table
        :user
      end

      def already_exists_exception
        UserAlreadyExists
      end

      def not_found_exception
        UserNotFound
      end
    end
  end
end
