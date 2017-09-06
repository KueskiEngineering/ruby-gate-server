# frozen_string_literal: true
require_relative 'relationship_controller'

module Gate
  module Controllers
    class RoleDescription < RelationshipController
      def main_field
        :role_id
      end

      def second_field
        :permission_id
      end

      def control_table
        :role_description
      end

      def id_field
        :role_description_id
      end

      def already_exists_exception
        PermissionAlreadyAssigned
      end
    end
  end
end
