# frozen_string_literal: true

require_relative '../lib/services'
require_relative '../lib/exception'
require_relative 'name_list_controller'

module Gate
  module Controllers
    ##
    # this class handles user
    class Permission < NameListController
      include Exceptions
      def initialize(name, site)
        @site = site
        super(name)
      end

      def id_field
        :permission_id
      end

      def name_field
        :name
      end

      def control_table
        :permission
      end

      def extra_fields
        { site_id: @site.id }
      end

      def primary_key_hash
        { name_field => name, site_id: @site.id }
      end

      def already_exists_exception
        PermissionAlreadyExists
      end

      def not_found_exception
        PermissionNotFound
      end

      def self.user_permissions(user, site)
        Services
          .database[:user_role]
          .inner_join(:role, [:role_id])
          .inner_join(:site, [:site_id])
          .inner_join(:user, [:user_id])
          .inner_join(:role_description, [:role_id])
          .inner_join(:permission, [:permission_id])
          .where(Sequel.qualify(:site, :name) => site, username: user,
                 Sequel.qualify(:role, :enabled) => true)
          .select_map(Sequel.qualify(:permission, :name))
      end
    end
  end
end
