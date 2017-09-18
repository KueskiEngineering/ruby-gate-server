# frozen_string_literal: true
require_relative 'relationship_controller'

module Gate
  module Controllers
    class UserRole < RelationshipController
      include Exceptions
      def main_field
        :role_id
      end

      def second_field
        :user_id
      end

      def control_table
        :user_role
      end

      def id_field
        :user_role_id
      end

      def already_exists_exception
        PermissionAlreadyAssigned
      end
    end
  end
end
