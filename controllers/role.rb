# frozen_string_literal: true

require_relative '../lib/services'
require_relative '../lib/exception'
require_relative 'name_list_controller'

module Gate
  module Controllers
    ##
    # this class handles user
    class Role < NameListController
      include Exceptions
      def initialize(name, site)
        @site = site
        super(name)
      end

      def id_field
        :role_id
      end

      def name_field
        :name
      end

      def control_table
        :role
      end

      def extra_fields
        { site_id: @site.id }
      end

      def not_found_exception
        RoleNotFound
      end

      def already_exists_exception
        RoleAlreadyExists
      end

      def primary_key_hash
        { name_field => name, site_id: @site.id }
      end
    end
  end
end
